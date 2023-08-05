library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Booth_Mult is
    Port (In_1, In_2 : in  std_logic_vector(7 downto 0);
          clk        : in  std_logic := '0';
          ready      : in  std_logic := '0';
          done       : out std_logic := '0';
          S          : out std_logic_vector(15 downto 0) := (others => '0'));
end Booth_Mult;

architecture arch of Booth_Mult is
    -- register values
    signal M, A, nextA : std_logic_vector(7 downto 0) := "00000000";
    signal Q, nextQ    : std_logic_vector(8 downto 0) := "000000000";

    -- state variable
    signal Counter : unsigned(3 downto 0) := "0000";
    -- enable controllers for the counter and shifter
    signal nextEnable, Enable, nextShiftEnable, shiftEnable : std_logic := '0';
    
    component ShiftRegister_17bit is
        Port (A      : in  std_logic_vector(7 downto 0);
              Q      : in  std_logic_vector(8 downto 0);
              Clk    : in  std_logic;
              Enable : in  std_logic;
              A_out  : out std_logic_vector(7 downto 0);
              Q_out  : out std_logic_vector(8 downto 0));
    end component;
    
    component DFlipFlop is
        Port (D, Clk  : in  std_logic;
              Q, QNot : out std_logic);
    end component;

begin
    -- architecture

    -- register for AQ
    AQ_register : ShiftRegister_17bit port map(
        A => nextA, Q => nextQ, Clk => Clk, Enable => shiftEnable, A_out => A, Q_out => Q
    );
    
    -- want to delay counter by one clock cycle after initialization
    Enable_storage : DFlipFlop port map(
    	D => nextEnable, Clk => Clk, Q => Enable, QNot => open
    );
    
    -- want to delay shifter until after counter has started
    ShiftEnable_storage : DFlipFlop port map(
    	D => nextShiftEnable, Clk => Clk, Q => shiftEnable, QNot => open
    );
    
    process (Clk, ready)
    begin
    	if (ready = '1') then
            -- check if at initial count
            if (Counter = 0) then
                -- delay enable to next cycle
            	nextEnable <= '1';
                
                -- initialize registers
                M <= In_1;
                nextA <= "00000000";
                nextQ <= In_2 & "0";
            end if;
            if (Enable = '1') then
                -- start shift
            	nextShiftEnable <= '1';
                if (rising_edge(Clk)) then
                    -- positive-edge triggered

                    -- increment state
                    Counter <= Counter + 1;
                    if (Counter < 8) then
                        -- in state: incomplete
                        if (Q(1 downto 0) = "01") then -- A = A + M
                            nextA <= std_logic_vector(signed(A) + signed(M));
                        elsif (Q(1 downto 0) = "10") then -- A = A - M
                            nextA <= std_logic_vector(signed(A) - signed(M));
                        else -- A = A
                            nextA <= A;
                        end if;
                        
                        nextQ <= Q;
                    elsif (Counter = 8) then
                        -- output
                    	S <= A & Q(8 downto 1);
                        done <= '1';
                        -- disable counter and shifter
                    	nextEnable <= '0';
                        nextShiftEnable <= '0';
                    end if;
                end if;
            end if;
        else
            -- disable counter and shifter
        	nextEnable <= '0';
            nextShiftEnable <= '0';
        end if;
    end process;
end arch;