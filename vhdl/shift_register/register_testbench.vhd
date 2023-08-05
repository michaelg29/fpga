library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity testbench is
-- empty
end testbench;

architecture tb of testbench is

-- structural component
component Register_8bit is
    Port (A_in  : in std_logic_vector(7 downto 0);
          Clk   : in std_logic;
          Q_out : out std_logic_vector(7 downto 0));
end component;

signal A_in, Q_out : std_logic_vector(7 downto 0);
signal Clk : std_logic;

begin
	DUT: Register_8bit port map(A_in, Clk, Q_out);
    process
    begin
        -- 0
        Clk <= '0';
        A_in <= "10111100";
        wait for 5 ns;

        -- 5
        Clk <= '1';
        wait for 5 ns;

        Clk <= '0';
        wait for 5 ns;

        Clk <= '1';
        wait for 5 ns;

        Clk <= '0';
        wait for 5 ns;

        Clk <= '1';
        wait for 5 ns;

        Clk <= '0';
        wait for 5 ns;

        Clk <= '1';
        wait for 5 ns;

        Clk <= '0';
        wait for 5 ns;

        -- run options
        -- tool: Mentor Questa 2020.1
        -- compile options: -2008
        -- run options: -voptargs=+acc=npr
        -- runtime: number of cycles to completion * period of clock
        
        wait;
    end process;
end tb;