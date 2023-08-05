library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TFlipFlop is
    Port (T, Clk  : in  std_logic;
          Q       : out std_logic := '0';
          QNot    : out std_logic := '1');
end TFlipFlop;

architecture TFlipFlop_arch of TFlipFlop is
begin
    process (Clk, T)
    begin
        if (rising_edge(Clk)) then
            if (T = '0') then
                Q <= Q;
                QNot <= NOT(Q);
            else
                Q <= NOT(Q);
                QNot <= Q;
            end if;
        end if;
    end process;
end TFlipFlop_arch;