library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftRegister_8bit is
    Port (Parallel_in  : in  signed(7 downto 0);
          Mode, Clk    : in  std_logic; -- mode = 0 if shift, 1 if load
          Parallel_out : out signed(7 downto 0) := (others => '0'));
end ShiftRegister_8bit;

architecture ShiftRegister_8bit_arch of ShiftRegister_8bit is
    signal D_in : std_logic_vector(7 downto 0);
    
    component DFlipFlop is
        Port (D, Clk  : in  std_logic;
              Q, QNot : out std_logic);
    end component;
begin
    process (Clk)
    begin
        if (rising_edge(Clk)) then
            Parallel_out <= Parallel_in(7) & Parallel_in(7 downto 1);
        end if;
    end process;
end ShiftRegister_8bit_arch;