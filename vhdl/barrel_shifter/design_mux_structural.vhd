library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- structural entity
entity MUX_structural is
port(
    A	: in  std_logic;
    B	: in  std_logic;
    S	: in  std_logic;
    Y	: out std_logic);
end MUX_structural;

architecture structural of MUX_structural is
begin
    -- if S is true, [A and not(S)] will never evaluate to true; will only return the result of [B and S]
    -- if S is true, Y <= B * S = B * 1 = B (multiplication theorem)
    
    -- if S is false, [B and S] will never evaluate to true; will only return the result of [A and not(S)]
    -- if S is false, Y <= A * not(S) = A * not(0) = A * 1 = A (multiplication theorem)
	Y <= (B and S) or (A and not(S));
end structural;