library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity testbench is
-- empty
end testbench;

architecture tb of testbench is

-- structural component
component ShiftRegister_17bit is
    Port (A  : in  signed(7 downto 0);
          Q  : in signed(7 downto 0);
          Clk    : in  std_logic; -- mode = 0 if shift, 1 if load
          A_out : out signed(7 downto 0);
          Q_out : out signed(7 downto 0);
          Q0_out : out std_logic);
end component;

signal A_in, Q_in, A_out, Q_out : signed(7 downto 0) := (others => '0');
signal Clk, Q0_out : std_logic := '0';

begin
	DUT: ShiftRegister_17bit port map(A_in, Q_in, Clk, A_out, Q_out, Q0_out);
    process
    begin
        -- 0
        Clk <= '0';
        wait for 5 ns;

        -- 5
        Clk <= '1';
        A_in <= "10110111";
        Q_in <= "01011010";
        wait for 5 ns;

        -- 10
        Clk <= '0';
        wait for 5 ns;

        -- 15
        Clk <= '1';
        A_in <= A_out;
        Q_in <= Q_out;
        wait for 5 ns;

        -- 20
        Clk <= '0';
        wait for 5 ns;

        -- 25
        Clk <= '1';
        A_in <= A_out;
        Q_in <= Q_out;
        wait for 5 ns;

        -- 20
        Clk <= '0';
        wait for 5 ns;

        -- 25
        Clk <= '1';
        A_in <= A_out;
        Q_in <= Q_out;
        wait for 5 ns;

        -- 20
        Clk <= '0';
        wait for 5 ns;

        -- 25
        Clk <= '1';
        A_in <= A_out;
        Q_in <= Q_out;
        wait for 5 ns;

        -- 20
        Clk <= '0';
        wait for 5 ns;

        -- 25
        Clk <= '1';
        wait for 5 ns;

        -- 20
        Clk <= '0';
        wait for 5 ns;

        -- 25
        Clk <= '1';
        wait for 5 ns;

        -- 20
        Clk <= '0';
        wait for 5 ns;

        -- 25
        Clk <= '1';
        wait for 5 ns;

        -- 20
        Clk <= '0';
        wait for 5 ns;

        -- 25
        Clk <= '1';
        wait for 5 ns;

        -- 20
        Clk <= '0';
        wait for 5 ns;

        -- 25
        Clk <= '1';
        wait for 5 ns;

        -- 20
        Clk <= '0';
        wait for 5 ns;

        -- 25
        Clk <= '1';
        wait for 5 ns;

        -- 20
        Clk <= '0';
        wait for 5 ns;

        -- 25
        Clk <= '1';
        wait for 5 ns;

        -- 20
        Clk <= '0';
        wait for 5 ns;

        -- 25
        Clk <= '1';
        wait for 5 ns;

        -- 20
        Clk <= '0';
        wait for 5 ns;

        -- 25
        Clk <= '1';
        wait for 5 ns;

        -- 20
        Clk <= '0';
        wait for 5 ns;

        -- 25
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