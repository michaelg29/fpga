library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SW is
    Port (Idx1, Idx2         : in  std_logic_vector(2 downto 0);
          Permutation_in     : in  std_logic;
          Out_idx1, Out_idx2 : out std_logic_vector(2 downto 0));
end SW;

architecture SW_arch of SW is

component MUX3bit is
    Port (A, B : in  std_logic_vector(2 downto 0);
          S    : in  std_logic;
          Y    : out std_logic_vector(2 downto 0));
end component;

begin
    -- architecture here
    MUX_0: MUX3bit port map (
        A => Idx1, B => Idx2, S => Permutation_in, Y => Out_idx1
    );
    MUX_1: MUX3bit port map (
        A => Idx2, B => Idx1, S => Permutation_in, Y => Out_idx2
    );
end SW_arch;