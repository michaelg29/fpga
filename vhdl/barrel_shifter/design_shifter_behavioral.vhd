library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- behavioral entity
entity barrel_shifter_behavioral is
    port (X     : in    std_logic_vector(3 downto 0);
          sel   : in    std_logic_vector(1 downto 0);
          Y     : out   std_logic_vector(3 downto 0));
end barrel_shifter_behavioral;

architecture behavioral of barrel_shifter_behavioral is
begin
    with sel select
        Y <= X when "00",                                   -- if s == "00" == 0, shift by 0 bits
             X (0 downto 0) & X (3 downto 1) when "01",     -- if s == "01" == 1, return x[0]x[3]x[2]x[1]
             X (1 downto 0) & X (3 downto 2) when "10",     -- if s == "10" == 2, return x[1]x[0]x[3]x[2]
             X (2 downto 0) & X (3 downto 3) when "11",     -- if s == "11" == 3, return x[2]x[1]x[0]x[3]
             X when others;                                 -- if not composed of 0s or 1s, return original
end behavioral;