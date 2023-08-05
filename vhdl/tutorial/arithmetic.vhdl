library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


signal X : SIGNED;
signal Y : UNSIGNED;

signal A : unsigned(3 downto 0);
signal B : signed(3 downto 0);
signal X2 : signed(4 downto 0);
signal C, D : std_logic_vector(3 downto 0);
signal CONCAT : std_logic_vector(8 downto 0);

A <= "1111"; -- 15
B <= "1111"; -- -1
C <= "1111"; -- does not represent a number
D <= "0000";
CONCAT <= C & D; -- "11110000"

C <= std_logic_vector(A);
D <= std_logic_vector(B);
A <= unsigned(C);
B <= signed(C);

X2 <= signed('0' & A) - (B(3) & B); -- create signed from unsigned A; subtract sign extended B

-- integers
signal I : integer range 0 to 100;
B <= TO_SIGNED(I, 4);
I <= TO_INTEGER(A);
-- must go from std_logic_vector to signed/unsigned then to integer

-- positional association
signal DATA : std_logic_vector(49 downto 0);
DATA <= "00000000000000000000000000000000000000000000000000";
DATA <= std_logic_vector(to_signed(0, 50)); -- confusing
DATA <= (others => '0');

signal DATA4 : std_logic_vector(3 downto 0);
DATA4 <= ('1', '0', '1', '1');
DATA4 <= "1011";
DATA4 <= (3 => '1', 2 => '0', others => '1');

-- ======================================
-- arithmetic ops
-- ======================================

-- n-bit adder, no carry in or carry out
signal X, Y, S : unsigned(N-1 downto 0); -- N bits
S <= X + Y;

-- n-bit adder
signal S2 : unsigned(N downto 0);
signal Cin : std_logic; -- 1 bit
-- at least one signal on RHS must have same number of bits as LHS
S2 <= ('0' & X) + Y + Cin; -- allow one more bit for carry out

-- unsigned multiplication
signal P : unsigned(2N - 1 downto 0); -- 2N bits
P <= X * Y;