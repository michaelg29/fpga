library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity testbench is
-- empty
end testbench;

architecture tb of testbench is

-- structural component
component TFlipFlop is
    Port (T, Clk  : in  std_logic;
          Q, QNot : out std_logic);
end component;

signal T, Clk, Q, QNot : std_logic;

begin
	DUT: TFlipFlop port map(T, Clk, Q, QNot);
    process
    begin
        -- 00
        Clk <= '0';
        T <= '0';
        wait for 2 ns;

        -- 02
        T <= '1';
        wait for 3 ns;

        -- 05
        Clk <= '1';
        wait for 2 ns;

        -- 07
        T <= '0';
        wait for 3 ns;

        -- 10
        Clk <= '0';
        wait for 5 ns;

        -- 15
        Clk <= '1';
        wait for 2 ns;

        -- 17
        T <= '1';
        wait for 3 ns;

        -- 20
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