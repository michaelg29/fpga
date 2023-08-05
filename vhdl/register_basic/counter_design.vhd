library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_4bit is
    Port (Clk, Enable, Reset : in  std_logic;
          Q_out              : out std_logic_vector(3 downto 0) := (others => '0');
          Carry_out          : out std_logic := '0');
end Counter_4bit;

architecture Counter_4bit_arch of Counter_4bit is
begin
    process (Reset, Clk, Enable)
    begin
        if (Reset = '1') then
            Q_out <= "0000";
            Carry_out <= '0';
        elsif (Enable = '1' AND rising_edge(Clk)) then
            if (unsigned(Q_out) = 15) then
                Carry_out <= '1';
            end if;
            Q_out <= std_logic_vector(unsigned(Q_out) + 1);
        end if;
    end process;
end Counter_4bit_arch;