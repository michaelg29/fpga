library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity testbench is
-- empty
end testbench;

architecture tb of testbench is

-- structural component
component MSBN is
    Port (In_1, In_2, In_3, In_4, In_5, In_6, In_7, In_8            : in    std_logic_vector(5 downto 0);
          Out_1, Out_2, Out_3, Out_4, Out_5, Out_6, Out_7, Out_8    : out   std_logic_vector(2 downto 0));
end component;

signal inval1, inval2, inval3, inval4, inval5, inval6, inval7, inval8: std_logic_vector(5 downto 0);
signal outval1, outval2, outval3, outval4, outval5, outval6, outval7, outval8: std_logic_vector(2 downto 0);

begin
	DUT: MSBN port map(inval1, inval2, inval3, inval4, inval5, inval6, inval7, inval8, outval1, outval2, outval3, outval4, outval5, outval6, outval7, outval8);
    process
    begin
    	-- testing
        inval1 <= "011001"; -- 25
        inval2 <= "000001"; -- 1
        inval3 <= "100000"; -- 32
        inval4 <= "011011"; -- 27
        inval5 <= "111100"; -- 60
        inval6 <= "001100"; -- 12
        inval7 <= "110110"; -- 54
        inval8 <= "110000"; -- 48
        wait for 1 ns;
        -- expect 2, 0, 4, 3, 7, 1, 6, 5
        -- = 010, 000, 100, 011, 111, 001, 110, 101

        inval1 <= "101101"; -- 45 
        inval2 <= "000101"; -- 5
        inval3 <= "000110"; -- 6
        inval4 <= "011011"; -- 27
        inval5 <= "010000"; -- 16
        inval6 <= "000111"; -- 7
        inval7 <= "111111"; -- 63
        inval8 <= "110000"; -- 48
        -- expect 5, 0, 1, 4, 3, 2, 7, 6
        -- = 101, 000, 001, 100, 011, 010, 111, 110
        wait for 1 ns;

        inval1 <= "101111"; -- 47
        inval2 <= "001000"; -- 8
        inval3 <= "100001"; -- 33
        inval4 <= "011000"; -- 24
        inval5 <= "011010"; -- 26
        inval6 <= "011110"; -- 30
        inval7 <= "110010"; -- 50
        inval8 <= "111010"; -- 58
        -- expect 5, 0, 4, 1, 2, 3, 6, 7
        wait for 1 ns;

        wait;
    end process;
end tb;