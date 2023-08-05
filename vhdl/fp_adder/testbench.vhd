library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity testbench is
-- empty
end testbench;

architecture tb of testbench is

-- structural component
component FP_Adder is
    Port (A, B : in  std_logic_vector (31 downto 0);
          rule : in  std_logic;
          S    : out std_logic_vector (31 downto 0));
end component;

signal a_in, b_in, s_out : std_logic_vector(31 downto 0);
signal rule_in : std_logic;

begin
	DUT: FP_Adder port map(a_in, b_in, rule_in, s_out);
    process
    begin
    	a_in <= "01000000011100000000000000000000";
        b_in <= "01000000101001000000000000000000";
        rule_in <= '0';
        wait for 1 ns;

        wait;
    end process;
end tb;