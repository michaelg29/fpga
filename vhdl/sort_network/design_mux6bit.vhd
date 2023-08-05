library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity MUX6bit is
    Port (A, B : in  std_logic_vector(5 downto 0);
          S    : in  std_logic;
          Y    : out std_logic_vector(5 downto 0));
end MUX6bit;

architecture MUX6bit_arch of MUX6bit is
begin
    -- implement MUX algorithm for each input bit
    Y(0) <= (B(0) and S) or (A(0) and not(S));
    Y(1) <= (B(1) and S) or (A(1) and not(S));
    Y(2) <= (B(2) and S) or (A(2) and not(S));
    Y(3) <= (B(3) and S) or (A(3) and not(S));
    Y(4) <= (B(4) and S) or (A(4) and not(S));
    Y(5) <= (B(5) and S) or (A(5) and not(S));
end MUX6bit_arch;