--TYPE State_type is (list_of_signal values)

architecture behavioural of FSM is
TYPE state_signal IS
    (RESET_STATE, S1, S2, S3, DONE);
SIGNAL state : state_signal;
begin
state_update : process (clk, reset)
    begin
    if reset = '1' then
        state <= RESET_STATE;
    elsif rising_edge(clk) then
        case state is
            when RESET_STATE =>
                if x = '0' then state <= S1; end if;
            when S1 =>
                if x = '0' then state <= S2; end if;
            when S2 =>
                if x = '0' then state <= S3; end if;
            when S3 =>
                if x = '0' then state <= DONE; end if;
        end case;
        end if;
        end process;

output_logic : process (state)
    begin
    case state is
        when RESET_STATE => Z <= '0';
        when S1 => Z <= '0';
        when S2 => Z <= '0';
        when S3 => Z <= '0';
        when DONE => Z <= '1';
    end case;
    end process;
end behavioural;

architecture behavioral2 of FSM is
    type state_type is (S0, S2, S3);
    attribute syn_encoding : STRING;
    attribute syn_encoding of state_type :
        TYPE IS "00 01 11";
    signal states : state_type;

    attribute syn_encoding of state_type : type is "default"; -- sequential (0-4 states), one-hot (5-50), gray (> 50)
    attribute syn_encoding of state_type : type is "one-hot";
    attribute syn_encoding of state_type : type is "sequential"; -- 0, 1, ...
    attribute syn_encoding of state_type : type is "gray"; -- M-bit, encodings for adjacent bits differ by 1 bit, represent 2M states
    attribute syn_encoding of state_type : type is "johnson"; -- like gray, less logic
    attribute syn_encoding of state_type : type is "compact"; -- fewest bits
    attribute syn_encoding of state_type : type is "safe"; -- detect illegal states with extra logic
begin
state_update2 : process(clk, reset)
    begin
    end process
end behavioral2;