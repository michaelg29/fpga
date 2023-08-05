library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity testbench is
-- empty
end testbench;

architecture tb of testbench is

-- structural component
component DFlipFlop is
    Port (D, Clk  : in  std_logic,
          Q, QNot : out std_logic := '0');
end component;

signal D, Clk, Q, QNot : std_logic;

begin
	DUT: DFlipFlop port map(D, Clk, Q, QNot);
    process
    begin
        -- 00
        clk <= '0';
        D <= '0';
        wait for 5 ns;

        -- 05
        D <= '1';
        wait for 5 ns;

        -- 10
        clk <= '1';
        wait for 5 ns;

        -- 15
        clk <= '0';
        wait for 2 ns;

        -- 17
        D <= '0';
        wait for 3 ns;

        -- 20
        clk <= '1';
        wait for 5 ns;

        -- 25
        clk <= '0';
        wait for 2 ns;

        -- 27
        D <= '1';
        wait for 3 ns;

        -- 30
        clk <= '1';
        wait for 2 ns;

        -- 32
        D <= '0';
        wait for 3 ns;

        -- 35
        clk <= '0';
        wait for 1 ns;

        -- 36
        D <= '1';
        wait for 2 ns;

        -- 38
        D <= '0';
        wait for 2 ns;

        -- 40
        clk <= '1';
        wait for 2 ns;

        -- 42
        D <= '1';
        wait for 3 ns;

        -- 45
        clk <= '0';
        wait for 2 ns;

        D <= '0';
        wait for 3 ns;

        -- run options
        -- tool: Mentor Questa 2020.1
        -- compile options: -2008
        -- run options: -voptargs=+acc=npr
        -- runtime: number of cycles to completion * period of clock
        
        wait;
    end process;
end tb;