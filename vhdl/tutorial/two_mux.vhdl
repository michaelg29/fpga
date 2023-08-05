library IEEE;
use std_logic_1164.all;

-- entity declaration
entity mux is
    port( A, B, C: in std_logic;
          H : in bit_vector(7 downto 0);
          G: out std_logic;
          EQ: out bit);
end mux;

-- architecture
architecture implementation of mux is
    signal D, E, F : std_logic;
    signal X : INTEGER range -16 to 15;
    signal Y : INTEGER; // defaults to -(2^31 - 1) to (2^31 - 1)
    signal SELECT_SIG : std_logic;
begin
    G <= (A and C) or (B and not C);

    with SELECT_SIG select
        G <= A when '0',
            B when others;
    
    G <= A when SELECT_SIG='0' else B;
end implementation;

entity XY_Gate
        port(X, Y : in std_logic;
             s1, s2: out std_logic);
    end entity;

    entity QZ_Gate
        port(Z1, Z2 : in std_logic;
             ST : out std_logic;
             Q : in std_logic_vector(7 downto 0));
    end entity;

-- hierarchy entity
entity widget is
    port ( D1, D2, SET : in std_logic;
           X : in std_logic_vector(7 downto 0);
           Q1, Q2, STATUS : out std_logic);
end widget;

architecture A of widget is
    signal I1, I2 : std_logic;

    -- nested components
    component XY_Gate
        port(X, Y : in std_logic;
             s1, s2: out std_logic);
    end component;

    component QZ_Gate
        port(Z1, Z2 : in std_logic;
             ST : out std_logic;
             Q : in std_logic_vector(7 downto 0));
    end component;

begin
    Gate1: XY_Gate port map (x => D1, y => D2, s1 => I1, s1 => STATUS);
    Gate2: XY_Gate port map (x => I1, s2 => Q2, y => I2, s1 => Q1);
    Gate3: QZ_Gate port map (Q => X, Z2 => I1, Z1 => SET, ST => I2);
end A;

