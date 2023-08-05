library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity testbench is
-- empty
end testbench;

architecture tb of testbench is

-- structural component
component Booth_Mult is
    Port (In_1, In_2 : in  std_logic_vector(7 downto 0);
          clk        : in  std_logic;
          ready      : in  std_logic;
          done       : out std_logic;
          S          : out std_logic_vector(15 downto 0));
end component;

signal In_1, In_2  : std_logic_vector(7 downto 0);
signal clk         : std_logic := '0';
signal ready, done : std_logic;
signal S           : std_logic_vector(15 downto 0);

begin
	DUT: Booth_Mult port map(In_1, In_2, clk, ready, done, S);
    process
    begin
        -- -73      * 90       = -6570
        -- 10110111 * 01011010 = 1110011001010110
        In_1 <= "10110111";
        In_2 <= "01011010";
       	ready <= '1';

        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;

        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;

        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;

        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;

        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;

        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;

        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;

        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;

        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;

        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
        
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;

        wait;
    end process;
end tb;