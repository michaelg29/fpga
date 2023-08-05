library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity testbench_structural is
-- empty
end testbench_structural;

architecture tbs of testbench_structural is

-- structural component
component barrel_shifter_structural is
port (X     : in    std_logic_vector(3 downto 0);
      sel   : in    std_logic_vector(1 downto 0);
      Y     : out   std_logic_vector(3 downto 0));
end component;

signal x_in, y_out: std_logic_vector(3 downto 0);
signal sel_in: std_logic_vector(1 downto 0);

begin
	-- connect DUT
    DUT: barrel_shifter_structural port map(x_in, sel_in, y_out);
    process
    begin
        x_in <= "1101"; -- = 13 = c
        
        -- sel = 0 => expect y = "1101" = 13 = d
        sel_in <= "00";
        wait for 1 ns;
        
        -- sel = 1 => expect y = "1110" = 14 = e
        sel_in <= "01";
        wait for 1 ns;

		-- sel = 2 => expect y = "0111" = 7
        sel_in <= "10";
        wait for 1 ns;
        
        -- sel = 3 => expect y = "1011" = 14 = b
        sel_in <= "11";
        wait for 1 ns;

        -- clear
        x_in <= "0000";
        sel_in <= "00";
        
        wait;
	end process;
end tbs;