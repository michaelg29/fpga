library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_17bit is
    Port (A_in  : in std_logic_vector(16 downto 0);
          Clk   : in std_logic;
          Q_out : out std_logic_vector(16 downto 0));
end Register_17bit;

architecture Register_17bit_arch of Register_17bit is
    component TFlipFlop is
        Port (T, Clk  : in  std_logic;
              Q       : out std_logic := '0';
              QNot    : out std_logic := '1');
    end component;

    component DFlipFlop is
        Port (D, Clk  : in  std_logic;
              Q, QNot : out std_logic);
    end component;
begin
    D0 : DFlipFlop port map(
        D => A_in(0), Clk => Clk, Q => Q_out(0), QNot => open
    );
    D1 : DFlipFlop port map(
        D => A_in(1), Clk => Clk, Q => Q_out(1), QNot => open
    );
    D2 : DFlipFlop port map(
        D => A_in(2), Clk => Clk, Q => Q_out(2), QNot => open
    );
    D3 : DFlipFlop port map(
        D => A_in(3), Clk => Clk, Q => Q_out(3), QNot => open
    );
    D4 : DFlipFlop port map(
        D => A_in(4), Clk => Clk, Q => Q_out(4), QNot => open
    );
    D5 : DFlipFlop port map(
        D => A_in(5), Clk => Clk, Q => Q_out(5), QNot => open
    );
    D6 : DFlipFlop port map(
        D => A_in(6), Clk => Clk, Q => Q_out(6), QNot => open
    );
    D7 : DFlipFlop port map(
        D => A_in(7), Clk => Clk, Q => Q_out(7), QNot => open
    );
    D8 : DFlipFlop port map(
        D => A_in(8), Clk => Clk, Q => Q_out(8), QNot => open
    );
    D9 : DFlipFlop port map(
        D => A_in(9), Clk => Clk, Q => Q_out(9), QNot => open
    );
    D10 : DFlipFlop port map(
        D => A_in(10), Clk => Clk, Q => Q_out(10), QNot => open
    );
    D11 : DFlipFlop port map(
        D => A_in(11), Clk => Clk, Q => Q_out(11), QNot => open
    );
    D12 : DFlipFlop port map(
        D => A_in(12), Clk => Clk, Q => Q_out(12), QNot => open
    );
    D13 : DFlipFlop port map(
        D => A_in(13), Clk => Clk, Q => Q_out(13), QNot => open
    );
    D14 : DFlipFlop port map(
        D => A_in(14), Clk => Clk, Q => Q_out(14), QNot => open
    );
    D15 : DFlipFlop port map(
        D => A_in(15), Clk => Clk, Q => Q_out(15), QNot => open
    );
    D16 : DFlipFlop port map(
        D => A_in(16), Clk => Clk, Q => Q_out(16), QNot => open
    );
end Register_17bit_arch;