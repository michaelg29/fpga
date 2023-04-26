
module synchronizer (
  input clk, in,
  output out
);

  reg r1, r2, r3;
  always @(posedge clk)
  begin
    r1 <= in;
    r2 <= r1; // output in sync (double FF syncrhonizer)
    r3 <= r2; // previous state
  end

  // rising edge
  assign out = ~r3 & r2;

endmodule

module lock (
  input clk, reset_in, b0_in, b1_in,
  output out, output [3:0] hex_display
);
  // syncrhonize inputs
  wire reset, b0, b1;
  button b_reset(.clk(clk), .in(reset_in), .out(reset));
  button b_0(.clk(clk), .in(b0_in), .out(b0));
  button b_1(.clk(clk), .in(b1_in), .out(b1));

  // state assignments
  parameter S_RESET = 0;
  parameter S_1 = 1;
  parameter S_2 = 2;
  parameter S_3 = 3;
  parameter S_4 = 4;
  parameter S_5 = 5;
  
  // output generation in sequential always
  // calculate outputs on synchronized next state
  reg [2:0] state, next_state;
  always @(*) begin
    // implement state transition diagram
    if (reset) next_state = S_RESET;
    else case (state)
      S_RESET: next_state = b0 ? S_1 : b1 ? S_RESET : state;
      S_0    : next_state = b0 ? S_1 : b1 ? S_2     : state;
      S_1    : next_state = b0 ? S_3 : b1 ? S_RESET : state;
      S_2    : next_state = b0 ? S_1 : b1 ? S_4     : state;
      S_3    : next_state = b0 ? S_3 : b1 ? S_5     : state;
      S_5    : next_state = b0 ? S_1 : b1 ? S_RESET : state;
      default: next_state = S_RESET;
    endcase
  end
  // synchronized state assignments
  always @(posedge clk) state <= next_state;

  // generate output
  assign out = (state == S_5);
  assign hex_display = {1'b0, state};
endmodule