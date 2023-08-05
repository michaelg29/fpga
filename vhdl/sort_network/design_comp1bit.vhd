library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comp1bit is
    Port (A, B, prevGr, prevEq, prevLs : in  std_logic;
          Gr, Eq, Ls                   : out std_logic);
end comp1bit;

architecture comp1bit_arch of comp1bit is
-- intermediate signal to store equality
signal equal : std_logic;

begin
    -- determine if the two input bits are equal
    equal <= (A and B) or (not(A) and not(B));

    -- greater if the current MSB is greater (larger weight than preceding bits) or if equal and the preceding bits returned greater
    Gr <= (A and not(B)) or (equal and prevGr);

    -- equal iff the current MSB is equal and the preceding bits returned equal
    Eq <= equal and prevEq;

    -- less if the current MSB is less (larger weight than preceding bits) or if equal and the preceding bits returned less
    Ls <= (not(A) and B) or (equal and prevLs);
end comp1bit_arch;