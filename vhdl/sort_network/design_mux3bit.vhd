library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity MUX3bit is
    Port (A, B : in  std_logic_vector(2 downto 0);
          S    : in  std_logic;
          Y    : out std_logic_vector(2 downto 0));
end MUX3bit;

architecture MUX3bit_arch of MUX3bit is
begin
    -- implement MUX algorithm for each input bit
    Y(0) <= (B(0) and S) or (A(0) and not(S));
    Y(1) <= (B(1) and S) or (A(1) and not(S));
    Y(2) <= (B(2) and S) or (A(2) and not(S));
end MUX3bit_arch;