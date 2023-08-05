-- processes
process_label : process (sensititivity)
-- declarations
begin
-- sequential statements
end process;

XOR1 : process(A, B)
begin
    C <= A xor B;

    if first_condition then
        -- statements
    elsif second_condition then
        -- statements
    else
        -- statements
    end if; -- first_condition
end process;

OR3_1 : process(A, B, C)
begin
    F <= '0'; -- default
    if A = '1' then F <= '1';
        elsif B = '1' then F <= '1';
        elsif C = '1' then F <= '1';
    end if; -- A = '1'
end process;

XOR2 : process
begin
    C <= A xor B;
    wait on A, B; -- wait on sensititivity_list;
end process;

P2 : process
begin
    case control_expression is
    when test_expression1 =>
        -- statements
    when test_expression2 =>
        -- statements
    when others =>
        -- statements
    end case;

    label : for parameters in range loop
        -- sequential statements
    end loop label;

    swap_loop : for i in 0 to 3 loop
        x(i) <= y(3 - i);
    end loop swap_loop;
end process;

OR3_2 : process (A, B, C)
begin
    case when A & B & C is -- concatenation
        when "000" => F <= '0';
        when others => F <= '1';
    end case;
end process;

DFF1 : process(RST_N, Clk)
begin
    if RST_N = '0' then -- asynchronous condition
        Q <= '0';
    elsif rising_edge(clk) then -- synchronous condition
        Q <= D; -- D is not in sensitivity list because do not respond to D input events
    end if; -- RST_N = '0'
    -- implied memory: Q holds value if no conditions are satisfied
end process;