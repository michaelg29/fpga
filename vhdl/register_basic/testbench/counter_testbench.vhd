library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity testbench is
-- empty
end testbench;

architecture tb of testbench is

-- structural component
component Counter_3bit is
    Port (Clk, Enable, Reset : in std_logic;
          Q_out       : out std_logic_vector(2 downto 0);
          Carry_out   : out std_logic);
end component;

signal Q_out : std_logic_vector(2 downto 0);
signal Clk, Enable, Reset, Carry_out : std_logic;

begin
	DUT: Counter_3bit port map(Clk, Enable, Reset, Q_out, Carry_out);
    process
    begin
        -- 0
        Clk <= '0';
        Enable <= '1';
        Reset <= '0';
        wait for 5 ns;

        -- 5
        Clk <= '1';
        wait for 5 ns;

        -- 5
        Clk <= '0';
        wait for 5 ns;

        -- 5
        Clk <= '1';
        wait for 5 ns;

        -- 5
        Clk <= '0';
        wait for 5 ns;

        -- 5
        Clk <= '1';
        wait for 5 ns;

        -- 5
        Clk <= '0';
        wait for 5 ns;

        -- 5
        Clk <= '1';
        Enable <= '0';
        wait for 5 ns;

        -- 5
        Clk <= '0';
        wait for 5 ns;

        -- 5
        Clk <= '1';
        Enable <= '1';
        wait for 5 ns;

        -- 5
        Clk <= '0';
        wait for 5 ns;

        -- 5
        Clk <= '1';
        Reset <= '1';
        wait for 5 ns;

        -- 5
        Clk <= '0';
        Reset <= '0';
        wait for 5 ns;

        -- 5
        Clk <= '1';
        wait for 5 ns;

        -- 5
        Reset <= '0';
        Clk <= '0';
        wait for 5 ns;

        -- 5
        Clk <= '1';
        wait for 5 ns;

        -- 5
        Clk <= '0';
        wait for 5 ns;

        -- 5
        Clk <= '1';
        wait for 5 ns;

        -- run options
        -- tool: Mentor Questa 2020.1
        -- compile options: -2008
        -- run options: -voptargs=+acc=npr
        -- runtime: number of cycles to completion * period of clock
        
        wait;
    end process;
end tb;