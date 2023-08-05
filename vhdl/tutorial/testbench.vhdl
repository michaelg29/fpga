library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- entity declaration, no I/O
entity tb_adder_combinatorial is

end tb_adder_combinatorial;

architecture test of tb_adder_combinatorial is
-- adder combinatorial ports
signal OP1 : std_logic_vector(3 downto 0);
signal OP2 : std_logic_vector(3 downto 0);
signal SUM : std_logic_vector(4 downto 0);
begin
    -- instantiate DUT as an entity
    dut : entity work.tb_adder_combinatorial -- in working directory
    port map(OP1 => OP1, OP2 => OP2, SUM => SUM)

    SENSE_PROC : process (CLK)
    begin
        if CLK'event and CLK = '1' then
            Q2 <= D2;
        end if;
    end process;

    WAIT_PROC : process
    begin
        wait until CLK' event and CLK = '1';
        Q1 <= D1;
    end process;

end architecture test;