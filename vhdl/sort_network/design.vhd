library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MSBN is
    Port (In_1, In_2, In_3, In_4, In_5, In_6, In_7, In_8            : in    std_logic_vector(5 downto 0);
          Out_1, Out_2, Out_3, Out_4, Out_5, Out_6, Out_7, Out_8    : out   std_logic_vector(2 downto 0));
end MSBN;

architecture MSBN_arch of MSBN is

component SO is
    Port (In1, In2        : in  std_logic_vector(5 downto 0);
          Out1, Out2      : out std_logic_vector(5 downto 0);
          Permutation_out : out std_logic);
end component;

component SW is
    Port (Idx1, Idx2         : in  std_logic_vector(2 downto 0);
          Permutation_in     : in  std_logic;
          Out_idx1, Out_idx2 : out std_logic_vector(2 downto 0));
end component;

-- 114 = 19 * 6: 113 downto 0
-- 57 = 19 * 3: 56 downto 0

-- lesser outputs stored in SO_out_1, greater in SO_out_2
signal SO_out_1, SO_out_2 : std_logic_vector(113 downto 0);
-- permutation outputs from master network
signal SO_perm_out        : std_logic_vector(18 downto 0);
-- outputs from slave network
signal SW_out_1, SW_out_2 : std_logic_vector(56 downto 0);

begin
    -- architecture here
    -- entity naming:
        -- Sorters: count top to bottom, left to right
        -- Switches: count top to bottom, right to left

    -- master network (output to slave network)
    SO_00: SO port map (
        In1 => In_8, In2 => In_7, 
        Out1 => SO_out_1(5 downto 0), Out2 => SO_out_2(5 downto 0), 
        Permutation_out => SO_perm_out(0)
    );
    SO_01: SO port map (
        In1 => In_6, In2 => In_5, 
        Out1 => SO_out_1(11 downto 6), Out2 => SO_out_2(11 downto 6), 
        Permutation_out => SO_perm_out(1)
    );
    SO_02: SO port map (
        In1 => In_4, In2 => In_3, 
        Out1 => SO_out_1(17 downto 12), Out2 => SO_out_2(17 downto 12), 
        Permutation_out => SO_perm_out(2)
    );
    SO_03: SO port map (
        In1 => In_2, In2 => In_1, 
        Out1 => SO_out_1(23 downto 18), Out2 => SO_out_2(23 downto 18), 
        Permutation_out => SO_perm_out(3)
    );

    SO_04: SO port map (
        In1 => SO_out_1(5 downto 0), In2 => SO_out_1(17 downto 12), 
        Out1 => SO_out_1(29 downto 24), Out2 => SO_out_2(29 downto 24), 
        Permutation_out => SO_perm_out(4)
    );
    SO_05: SO port map (
        In1 => SO_out_1(11 downto 6), In2 => SO_out_1(23 downto 18), 
        Out1 => SO_out_1(35 downto 30), Out2 => SO_out_2(35 downto 30), 
        Permutation_out => SO_perm_out(5)
    );
    SO_06: SO port map (
        In1 => SO_out_2(5 downto 0), In2 => SO_out_2(17 downto 12), 
        Out1 => SO_out_1(41 downto 36), Out2 => SO_out_2(41 downto 36), 
        Permutation_out => SO_perm_out(6)
    );
    SO_07: SO port map (
        In1 => SO_out_2(11 downto 6), In2 => SO_out_2(23 downto 18), 
        Out1 => SO_out_1(47 downto 42), Out2 => SO_out_2(47 downto 42), 
        Permutation_out => SO_perm_out(7)
    );

    SO_08: SO port map (
        In1 => SO_out_1(29 downto 24), In2 => SO_out_1(35 downto 30), 
        Out1 => SO_out_1(53 downto 48), Out2 => SO_out_2(53 downto 48), 
        Permutation_out => SO_perm_out(8)
    );
    SO_09: SO port map (
        In1 => SO_out_2(29 downto 24), In2 => SO_out_1(41 downto 36), 
        Out1 => SO_out_1(59 downto 54), Out2 => SO_out_2(59 downto 54), 
        Permutation_out => SO_perm_out(9)
    );
    SO_10: SO port map (
        In1 => SO_out_2(35 downto 30), In2 => SO_out_1(47 downto 42), 
        Out1 => SO_out_1(65 downto 60), Out2 => SO_out_2(65 downto 60), 
        Permutation_out => SO_perm_out(10)
    );
    SO_11: SO port map (
        In1 => SO_out_2(41 downto 36), In2 => SO_out_2(47 downto 42), 
        Out1 => SO_out_1(71 downto 66), Out2 => SO_out_2(71 downto 66), 
        Permutation_out => SO_perm_out(11)
    );

    SO_12: SO port map (
        In1 => SO_out_1(59 downto 54), In2 => SO_out_1(65 downto 60), 
        Out1 => SO_out_1(77 downto 72), Out2 => SO_out_2(77 downto 72), 
        Permutation_out => SO_perm_out(12)
    );
    SO_13: SO port map (
        In1 => SO_out_2(59 downto 54), In2 => SO_out_2(65 downto 60), 
        Out1 => SO_out_1(83 downto 78), Out2 => SO_out_2(83 downto 78), 
        Permutation_out => SO_perm_out(13)
    );

    SO_14: SO port map (
        In1 => SO_out_2(53 downto 48), In2 => SO_out_1(83 downto 78), 
        Out1 => SO_out_1(89 downto 84), Out2 => SO_out_2(89 downto 84), 
        Permutation_out => SO_perm_out(14)
    );
    SO_15: SO port map (
        In1 => SO_out_2(77 downto 72), In2 => SO_out_1(71 downto 66), 
        Out1 => SO_out_1(95 downto 90), Out2 => SO_out_2(95 downto 90), 
        Permutation_out => SO_perm_out(15)
    );

    SO_16: SO port map (
        In1 => SO_out_1(89 downto 84), In2 => SO_out_1(77 downto 72), 
        Out1 => SO_out_1(101 downto 96), Out2 => SO_out_2(101 downto 96), 
        Permutation_out => SO_perm_out(16)
    );
    SO_17: SO port map (
        In1 => SO_out_1(95 downto 90), In2 => SO_out_2(89 downto 84), 
        Out1 => SO_out_1(107 downto 102), Out2 => SO_out_2(107 downto 102), 
        Permutation_out => SO_perm_out(17)
    );
    SO_18: SO port map (
        In1 => SO_out_2(83 downto 78), In2 => SO_out_2(95 downto 90), 
        Out1 => SO_out_1(113 downto 108), Out2 => SO_out_2(113 downto 108), 
        Permutation_out => SO_perm_out(18)
    );

    --Out_1 <= SO_out_1(53 downto 48);
    --Out_2 <= SO_out_1(101 downto 96);
    --Out_3 <= SO_out_2(101 downto 96);
    --Out_4 <= SO_out_1(107 downto 102);
    --Out_5 <= SO_out_2(107 downto 102);
    --Out_6 <= SO_out_1(113 downto 108);
    --Out_7 <= SO_out_2(113 downto 108);
    --Out_8 <= SO_out_2(71 downto 66);

    -- slave network (input from master network, output to output)
    SW_00: SW port map (
        Idx1 => "001", Idx2 => "010",
        Permutation_in => SO_perm_out(16),
        Out_idx1 => SW_out_1(2 downto 0), Out_idx2 => SW_out_2(2 downto 0)
    );
    SW_01: SW port map (
        Idx1 => "011", Idx2 => "100",
        Permutation_in => SO_perm_out(17),
        Out_idx1 => SW_out_1(5 downto 3), Out_idx2 => SW_out_2(5 downto 3)
    );
    SW_02: SW port map (
        Idx1 => "101", Idx2 => "110",
        Permutation_in => SO_perm_out(18),
        Out_idx1 => SW_out_1(8 downto 6), Out_idx2 => SW_out_2(8 downto 6)
    );

    SW_03: SW port map (
        Idx1 => SW_out_1(2 downto 0), Idx2 => SW_out_2(5 downto 3),
        Permutation_in => SO_perm_out(14),
        Out_idx1 => SW_out_1(11 downto 9), Out_idx2 => SW_out_2(11 downto 9)
    );
    SW_04: SW port map (
        Idx1 => SW_out_1(5 downto 3), Idx2 => SW_out_2(8 downto 6),
        Permutation_in => SO_perm_out(15),
        Out_idx1 => SW_out_1(14 downto 12), Out_idx2 => SW_out_2(14 downto 12)
    );

    SW_05: SW port map (
        Idx1 => SW_out_2(2 downto 0), Idx2 => SW_out_1(14 downto 12),
        Permutation_in => SO_perm_out(12),
        Out_idx1 => SW_out_1(17 downto 15), Out_idx2 => SW_out_2(17 downto 15)
    );
    SW_06: SW port map (
        Idx1 => SW_out_2(11 downto 9), Idx2 => SW_out_1(8 downto 6),
        Permutation_in => SO_perm_out(13),
        Out_idx1 => SW_out_1(20 downto 18), Out_idx2 => SW_out_2(20 downto 18)
    );

    SW_07: SW port map (
        Idx1 => "000", Idx2 => SW_out_1(11 downto 9),
        Permutation_in => SO_perm_out(8),
        Out_idx1 => SW_out_1(23 downto 21), Out_idx2 => SW_out_2(23 downto 21)
    );
    SW_08: SW port map (
        Idx1 => SW_out_1(17 downto 15), Idx2 => SW_out_1(20 downto 18),
        Permutation_in => SO_perm_out(9),
        Out_idx1 => SW_out_1(26 downto 24), Out_idx2 => SW_out_2(26 downto 24)
    );
    SW_09: SW port map (
        Idx1 => SW_out_2(17 downto 15), Idx2 => SW_out_2(20 downto 18),
        Permutation_in => SO_perm_out(10),
        Out_idx1 => SW_out_1(29 downto 27), Out_idx2 => SW_out_2(29 downto 27)
    );
    SW_10: SW port map (
        Idx1 => SW_out_2(14 downto 12), Idx2 => "111",
        Permutation_in => SO_perm_out(11),
        Out_idx1 => SW_out_1(32 downto 30), Out_idx2 => SW_out_2(32 downto 30)
    );

    SW_11: SW port map (
        Idx1 => SW_out_1(23 downto 21), Idx2 => SW_out_1(26 downto 24),
        Permutation_in => SO_perm_out(4),
        Out_idx1 => SW_out_1(35 downto 33), Out_idx2 => SW_out_2(35 downto 33)
    );
    SW_12: SW port map (
        Idx1 => SW_out_2(23 downto 21), Idx2 => SW_out_1(29 downto 27),
        Permutation_in => SO_perm_out(5),
        Out_idx1 => SW_out_1(38 downto 36), Out_idx2 => SW_out_2(38 downto 36)
    );
    SW_13: SW port map (
        Idx1 => SW_out_2(26 downto 24), Idx2 => SW_out_1(32 downto 30),
        Permutation_in => SO_perm_out(6),
        Out_idx1 => SW_out_1(41 downto 39), Out_idx2 => SW_out_2(41 downto 39)
    );
    SW_14: SW port map (
        Idx1 => SW_out_2(29 downto 27), Idx2 => SW_out_2(32 downto 30),
        Permutation_in => SO_perm_out(7),
        Out_idx1 => SW_out_1(44 downto 42), Out_idx2 => SW_out_2(44 downto 42)
    );

    SW_15: SW port map (
        Idx1 => SW_out_1(35 downto 33), Idx2 => SW_out_1(41 downto 39),
        Permutation_in => SO_perm_out(0),
        Out_idx1 => SW_out_1(47 downto 45), Out_idx2 => SW_out_2(47 downto 45)
    );
    SW_16: SW port map (
        Idx1 => SW_out_1(38 downto 36), Idx2 => SW_out_1(44 downto 42),
        Permutation_in => SO_perm_out(1),
        Out_idx1 => SW_out_1(50 downto 48), Out_idx2 => SW_out_2(50 downto 48)
    );
    SW_17: SW port map (
        Idx1 => SW_out_2(35 downto 33), Idx2 => SW_out_2(41 downto 39),
        Permutation_in => SO_perm_out(2),
        Out_idx1 => SW_out_1(53 downto 51), Out_idx2 => SW_out_2(53 downto 51)
    );
    SW_18: SW port map (
        Idx1 => SW_out_2(38 downto 36), Idx2 => SW_out_2(44 downto 42),
        Permutation_in => SO_perm_out(3),
        Out_idx1 => SW_out_1(56 downto 54), Out_idx2 => SW_out_2(56 downto 54)
    );

    Out_1 <= SW_out_2(56 downto 54);
    Out_2 <= SW_out_1(56 downto 54);
    Out_3 <= SW_out_2(53 downto 51);
    Out_4 <= SW_out_1(53 downto 51);
    Out_5 <= SW_out_2(50 downto 48);
    Out_6 <= SW_out_1(50 downto 48);
    Out_7 <= SW_out_2(47 downto 45);
    Out_8 <= SW_out_1(47 downto 45);
end MSBN_arch;