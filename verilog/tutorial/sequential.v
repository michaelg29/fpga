module mux4(
  input a, b, c, d,
  input [1:0] sel,
  output reg z, zbar
);

  // *: sensitivity list (can also be: @(a, b, c, d, sel))
  // LHS assignments must be reg (use registers)
  always @(*) begin
    if (sel == 2'b00) z = a;
    else if (sel == 2'b01) z = b;
    else if (sel == 2'b10) z = c;
    else if (sel == 2'b11) z = d;
    else z = 1'bx; // sel is unknown

    zbar = ~z;
  end

  // combinatoral always @(*) block => blocking assignment
  always @(*) begin
    case (sel)
      2'b00: z = a;
      2'b01: z = b;
      2'b10: z = c;
      2'b11: z = d;
      default: z = 1'bx; // sel is X or Z
    end case
    zbar = ~z;
  end

endmodule

module nonblocking (
  input in, clk,
  output reg out
);

  reg q1, q2;

  // non-blocking, defer assignments to q1, q2, out until end of block
  always @(posedge clk) begin
    q1 <= in;
    q2 <= q1; // use old q1
    out <= q2;
  end

endmodule

module counter (
  input clk, enb, clr,
  output reg [3:0] count
);

  always @(posedge clk) begin
    count <= clr ? 4'b0 : (enb ? count + 1 : count);
  end

endmodule
