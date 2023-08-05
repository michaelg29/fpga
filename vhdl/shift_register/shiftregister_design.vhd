library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister_17bit is
    Port (A      : in  std_logic_vector(7 downto 0);
          Q      : in  std_logic_vector(8 downto 0);
          Clk    : in  std_logic;
          Enable : in  std_logic;
          A_out  : out std_logic_vector(7 downto 0) := "00000000";
          Q_out  : out std_logic_vector(8 downto 0) := "000000000");
end ShiftRegister_17bit;

architecture ShiftRegister_17bit_arch of ShiftRegister_17bit is
begin
    process (Clk, Enable)
    begin
    	if (falling_edge(Clk)) then
       		if (Enable = '1') then
              	Q_out <= A(0) & Q(8 downto 1);
              	A_out <= A(7) & A(7 downto 1);
          	else
              	Q_out <= Q;
              	A_out <= A;
          	end if;
        end if;
    end process;
end ShiftRegister_17bit_arch;