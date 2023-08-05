library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    generic (W  : integer := 8);
    port (i_clk   : in  std_logic;
          i_rst_n : in  std_logic;
          i_a     : in  std_logic_vector(W-1 downto 0);
          i_b     : in  std_logic_vector(W-1 downto 0);
          o_s     : out std_logic_vector(W-1 downto 0);
          o_c     : out std_logic);
end adder;

architecture rtl of adder is
    signal total_sum : unsigned(W downto 0);
begin

    o_s <= std_logic_vector(total_sum(W-1 downto 0));
    o_c <= total_sum(W);

    P_COMPUTE : process (i_rst_n, i_clk)
    begin
        if (i_rst_n = '0') then
            total_sum <= (others => '0');
        elsif (i_clk'event and i_clk = '1') then
            total_sum <= unsigned('0' & i_a) + unsigned('0' & i_b);
        end if;
    end process P_COMPUTE;

end rtl;