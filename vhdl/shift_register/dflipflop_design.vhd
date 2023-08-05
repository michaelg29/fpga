library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFlipFlop is
    Port (D, Clk : in  std_logic;
          Q      : out std_logic := '0';
          QNot   : out std_logic := '1');
end DFlipFlop;

architecture DFlipFlop_arch of DFlipFlop is
begin
    process (Clk, D)
    begin
        if (rising_edge(Clk)) then
            Q <= D;
            QNot <= NOT(D);
        end if;
    end process;
end DFlipFlop_arch;