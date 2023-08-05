library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DLatch_comp is
    Port (D : in std_logic;
			Clk : in std_logic;
			Q : out std_logic := '0';
			QNot : out std_logic := '1');
end DLatch_comp;

architecture DLatch_arch of DLatch_comp is

signal Q1, Q2 : std_logic := '0';
signal QNot1, QNot2 : std_logic := '1';

begin
	 Q1 <= D NAND CLK;
	 QNot1 <= not(D) NAND Clk;
	 Q2 <= Q1 NAND QNot2;
	 QNot2 <= QNot1 NAND Q2;
	 Q <= Q2;
	 QNot <= QNot2;
end DLatch_arch;

------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFlipFlop is
	Port (D, Clk : in std_logic;
			Q		: out std_logic := '0';
			QNot	: out std_logic := '1');
end DFlipFlop;

architecture DFlipFlop_arch of DFlipFlop is

component DLatch_comp is
	Port (D : in std_logic;
			Clk : in std_logic;
			Q : out std_logic := '0';
			QNot : out std_logic := '1');
end component;

signal Q1 : std_logic := '0';
signal QNot1 : std_logic := '1';
begin

DLatch_1 : DLatch_comp port map(
	D => D, Clk => not(Clk), Q => Q1, QNot => QNot1
);
DLatch_2 : DLatch_comp port map(
	D => Q1, Clk => Clk, Q => Q, QNot => QNot
);

end DFlipFlop_arch;
