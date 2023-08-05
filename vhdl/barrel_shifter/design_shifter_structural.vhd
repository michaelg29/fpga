library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- structural entity
entity barrel_shifter_structural is
    port (X     : in    std_logic_vector(3 downto 0);
          sel   : in    std_logic_vector(1 downto 0);
          Y     : out   std_logic_vector(3 downto 0));
end barrel_shifter_structural;

architecture structural of barrel_shifter_structural is

-- intermediate signals
signal mux_r1: std_logic_vector(3 downto 0); -- mux outputs after round 1

-- MUX component
component MUX_structural is
port(
    A	: in  std_logic;
    B	: in  std_logic;
    S	: in  std_logic;
    Y	: out std_logic);
end component;
begin

-- MUX components
-- numbers
	-- if MUX_0i
		-- first shift stage, takes in S[0] as S
		-- takes in x(i) as A, x(i + 1 mod 4) as B
		-- outputs to mux_r1(i)
	-- if MUX_1i
		-- second shift stage, takes in S[1] as S
		-- takes in mux_r1(i) as A, mux_r1(i + 2 mod 4) as B
		-- outputs to y_out(i)

MUX_00: MUX_structural port map (
	A => X(0), B => X(1), S => sel(0), Y => mux_r1(0)
);
MUX_01: MUX_structural port map (
	A => X(1), B => X(2), S => sel(0), Y => mux_r1(1)
);
MUX_02: MUX_structural port map (
	A => X(2), B => X(3), S => sel(0), Y => mux_r1(2)
);
MUX_03: MUX_structural port map (
	A => X(3), B => X(0), S => sel(0), Y => mux_r1(3)
);

MUX_10: MUX_structural port map (
	A => mux_r1(0), B => mux_r1(2), S => sel(1), Y => Y(0)
);
MUX_11: MUX_structural port map (
	A => mux_r1(1), B => mux_r1(3), S => sel(1), Y => Y(1)
);
MUX_12: MUX_structural port map (
	A => mux_r1(2), B => mux_r1(0), S => sel(1), Y => Y(2)
);
MUX_13: MUX_structural port map (
	A => mux_r1(3), B => mux_r1(1), S => sel(1), Y => Y(3)
);
    
end structural;