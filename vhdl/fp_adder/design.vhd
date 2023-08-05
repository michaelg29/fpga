library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FP_Adder is
    -- makeup of the input
    -- S(31) - the sign (1 for -ve, 0 for +ve)
    -- S(30 downto 23) - the signed exponnet
    -- S(22 downto 0) - the unsigned mantissa
    Port (A, B : in  std_logic_vector (31 downto 0);
          rule : in std_logic;
          S    : out std_logic_vector (31 downto 0));
end FP_Adder;

architecture fpadder_arch of FP_Adder is
    -- intermediate values
    signal shiftAmt : integer range 255 downto 0; -- difference in exponents
    signal exponentShift : integer; -- shift amount to normalize
    signal roundInc : unsigned (0 downto 0); -- value of increment if necessary

    -- intermediate arrays
    signal larger, smaller : std_logic_vector(31 downto 0); -- signals for the larger and smaller numbers
    signal A_E, B_E, larger_E : unsigned (8 downto 0); -- exponent placeholders
    signal MANTISSA_SUM, larger_man, smaller_man : std_logic_vector (24 downto 0); -- sum placeholders
begin
    A_E <= '0' & unsigned(A (30 downto 23));
    B_E <= '0' & unsigned(B (30 downto 23));

    -- comparison process
    COMPARISON : process(A_E, B_E) is
    begin
        -- determine which number is larger via exponent
        if (A_E > B_E) then
            -- A larger
            larger <= A;
            smaller <= B;

            larger_E <= A_E;
            shiftAmt <= to_integer(A_E - B_E);
		elsif (A_E = B_E) then
        	-- compare mantissa if exponents equal
            if (to_integer(unsigned(A (22 downto 0))) >= to_integer(unsigned(B (22 downto 0)))) then
            	larger <= A;
                smaller <= B;
          	else
            	larger <= B;
                smaller <= A;
          	end if;
                
            larger_E <= A_E;
            shiftAmt <= to_integer(A_E - B_E);
        else
            -- B larger
            larger <= B;
            smaller <= A;

            larger_E <= B_E;
            shiftAmt <= to_integer(B_E - A_E);
        end if;
    end process COMPARISON;

    -- do shift
    DO_SHIFT : process(shiftAmt, larger, smaller) is
    begin
        larger_man <= "01" & larger (22 downto 0);
        smaller_man <= "0000000000000000000000000";
        if (shiftAmt < 23) then
            smaller_man(23 - shiftAmt) <= '1';
            smaller_man(23 - shiftAmt - 1 downto 0) <= smaller(22 downto shiftAmt);

            -- ROUNDING for extra credit
            -- consider rounding if applicable (nearest, ties away from zero)
            if (shiftAmt > 0 and rule = '1') then
                if (smaller(shiftAmt - 1) = '1') then
                    roundInc <= "1";
                else
                    roundInc <= "0";
                end if;
            else
                roundInc <= "0";
            end if;
        elsif (shiftAmt = 23) then
            smaller_man(0) <= '1';
        end if;
    end process DO_SHIFT;

    -- perform addition
    DO_ADD : process(larger, smaller, larger_man, smaller_man, roundInc) is
    begin
        -- perform signed addition on range (24 bits including implicit 1)
        if (larger(31) = smaller(31)) then
            MANTISSA_SUM <= std_logic_vector(unsigned(larger_man) + unsigned(smaller_man) + roundInc);
            --MANTISSA_SUM <= std_logic_vector(unsigned(larger_man) + unsigned(smaller_man));
        else
            MANTISSA_SUM <= std_logic_vector(unsigned(larger_man) - unsigned(smaller_man) + roundInc);
            --MANTISSA_SUM <= std_logic_vector(unsigned(larger_man) - unsigned(smaller_man));
        end if;

        -- resultant sign is the sign of the larger summand
        S(31) <= larger(31);
    end process DO_ADD;

    -- perform normalization
    DO_NORMALIZE : process(MANTISSA_SUM, shiftAmt) is
        variable index : integer := 24;
    begin
        -- find first 1 in the sum, increment the exponent shift
        exponentShift <= -1;
        
        index := 24;

        -- first iterate through the sum
        while (index >= 0 and index <= 24) loop
            if (MANTISSA_SUM(index) = '1') then
                exit;
            end if;
            index := index - 1;
            exponentShift <= exponentShift + 1;
        end loop;

        if (index < 0) then
            -- must iterate through shifted part of the smaller element
            if (shiftAmt = 0) then
                -- sum is zero
                exponentShift <= 0;
            else
                index := shiftAmt - 1;
                while (index >= 0 and index <= 24) loop
                    if (smaller_man(index) = '1') then
                        exit;
                    end if;
                    index := index - 1;
                    exponentShift <= exponentShift + 1;
                end loop;
            end if;
        end if;
    end process DO_NORMALIZE;

    -- output
    DO_OUTPUT : process(MANTISSA_SUM, shiftAmt, exponentShift, larger_E, smaller) is
        variable mantissaI : integer;
        variable difference : integer;
    begin
    	difference := to_integer(larger_E) - exponentShift;
    
        S(30 downto 0) <= "0000000000000000000000000000000";
        if (difference > 255) then
            -- infinity, sign is pre-determined
            S(30 downto 23) <= "11111111";
            S(22 downto 0) <= "00000000000000000000000";

            if (larger(31) /= smaller(31)) then
                -- make NaN
                S(22) <= '1';
            end if;
        elsif (difference >= 0) then
            -- exponent in real range
            S(30 downto 23) <= std_logic_vector(
            	to_unsigned(
                	to_integer(larger_E) - exponentShift
                , 8)
            );

            mantissaI := 22 - exponentShift;
            if (mantissaI >= 22) then
                -- take all bits from the MANTISSA_SUM
                S(22 downto 0) <= MANTISSA_SUM(mantissaI downto -exponentShift);
            elsif (mantissaI >= 0) then
                -- take 22-exponentShift bits from the MANTISSA_SUM
                --S(22 downto exponentShift) <= MANTISSA_SUM(mantissaI downto 0);
                -- take exponentShift bits from the smaller value (that may have been shifted)
                if (shiftAmt >= exponentShift) then
                    --S(exponentShift - 1 downto 0) <= smaller(shiftAmt downto shiftAmt - exponentShift + 1);
                else
                    --S(exponentShift - 1 downto exponentShift - shiftAmt) <= smaller(shiftAmt - 1 downto 0);
                end if;
            end if;
        end if;    
    end process DO_OUTPUT;
end fpadder_arch;