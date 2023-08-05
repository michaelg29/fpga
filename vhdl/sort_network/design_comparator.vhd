library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comparator is
    Port (A, B : in  std_logic_vector(5 downto 0);
          F    : out std_logic);
end comparator;

architecture comparator_arch of comparator is

-- component to sequentially compare corresponding bits
component comp1bit is
    Port (A, B, prevGr, prevEq, prevLs : in  std_logic;
          Gr, Eq, Ls                   : out std_logic);
end component;

-- array to store outputs of each comparator
signal gr, eq, ls : std_logic_vector(5 downto 0);
begin
    -- start at LSB, move left to MSB
    -- get comparison, store output in the three output arrays
    -- output of the higher level comparator is the output of the last 1-bit comparator
        -- return if the 5th 1-bit comparator outputs greater

    -- compare 0th bit (LSB); previous Gr,Eq,Ls = 0 because no preceding bits
    COMP_0: comp1bit port map(
        A => A(0), B => B(0), prevGr => '0', prevEq => '0', prevLs => '0', -- 
        Gr => gr(0), Eq => eq(0), Ls => ls(0)
    );
    -- compare 1st bit; take recursive output of the comparison of the 0th bit
    COMP_1: comp1bit port map(
        A => A(1), B => B(1), prevGr => gr(0), prevEq => eq(0), prevLs => ls(0),
        Gr => gr(1), Eq => eq(1), Ls => ls(1)
    );
    -- compare 2nd bit; take recursive output of the comparison of bits 0 -> 1
    COMP_2: comp1bit port map(
        A => A(2), B => B(2), prevGr => gr(1), prevEq => eq(1), prevLs => ls(1),
        Gr => gr(2), Eq => eq(2), Ls => ls(2)
    );
    -- compare 3rd bit; take recursive output of the comparison of bits 0 -> 2
    COMP_3: comp1bit port map(
        A => A(3), B => B(3), prevGr => gr(2), prevEq => eq(2), prevLs => ls(2),
        Gr => gr(3), Eq => eq(3), Ls => ls(3)
    );
    -- compare 4th bit; take recursive output of the comparison of bits 0 -> 3
    COMP_4: comp1bit port map(
        A => A(4), B => B(4), prevGr => gr(3), prevEq => eq(3), prevLs => ls(3),
        Gr => gr(4), Eq => eq(4), Ls => ls(4)
    );
    -- compare 5th bit (MSB); take recursive output of the comparison of bits 0 -> 4
    COMP_5: comp1bit port map(
        A => A(5), B => B(5), prevGr => gr(4), prevEq => eq(4), prevLs => ls(4),
        Gr => gr(5), Eq => eq(5), Ls => ls(5)
    );

    F <= gr(5);
end comparator_arch;