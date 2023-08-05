library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SO is
    Port (In1, In2        : in  std_logic_vector(5 downto 0);
          Out1, Out2      : out std_logic_vector(5 downto 0);
          Permutation_out : out std_logic);
end SO;

architecture SO_arch of SO is
signal larger : std_logic;

component comparator is
    Port (A, B : in  std_logic_vector(5 downto 0);
          F    : out std_logic);
end component;

component MUX6bit is
    Port (A, B : in  std_logic_vector(5 downto 0);
          S	   : in  std_logic;
    	  Y	   : out std_logic_vector(5 downto 0));
end component;

begin
    -- architecture here
    -- compare the inputs
    COMP: comparator port map(
        A => In1, B => In2, F => larger
    );

    -- set the lesser input as the first output
    MUX_0: MUX6bit port map (
        A => In1, B => In2, S => larger, Y => Out1
    );

    -- set the greater input as the second output
    MUX_1: MUX6bit port map (
        A => In2, B => In1, S => larger, Y => Out2
    );

    Permutation_out <= larger;

end SO_arch;