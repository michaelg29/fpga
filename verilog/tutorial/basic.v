`default_nettype none

module mux2
  #(parameter W = 1) // data width, default 1 bit
  (
    input [W-1:0] a, b
    input sel,
    output [W-1:0] z, zbar
  );
  wire selbar, z1, z2;

  // concurrent assignments
  // not, buf, and, nand, or, nor, xor, xnor
  not i1(selbar, sel); // selbar = sel'
  and a1(z1, a, selbar); // z1 = a * selbar
  and a2(z2, b, sel); // z2 = b * sel
  or o1(z, z1, z2); // z = z1 + z2
  not i2(zbar, z); // zbar = z'

  // dataflow execution (evaluations triggered on events)
  assign z = sel ? b : a;
  assign zbar = ~z;
endmodule

module mux4 
  #(parameter W = 1) // data width, default 1 bit
  (
    input [W-1:0] d0, d1, d2, d3,
    input [1:0] sel,
    output [W-1:0] z
  );
  wire z1, z2;
  mux2 #(.W(W)) m1(.sel(sel[0]), .a(d0), .b(d1), .z(z1)); // do not use zbar
  mux2 #(.W(W)) m2(.sel(sel[0]), .a(d2), .b(d3), .z(z2));
  mux2 #(.W(W)) m3(.sel(sel[1]), .a(z1), .b(z2), .z(z));
endmodule

module add32 (
  input [31:0] a, b,
  input cin,
  output [31:0] sum,
  output cout,
  output test
);
  // Arithmetic operations
  // -a: negate
  // a + b, a - b, a * b, a / b, a % b, a ** b (exp), a << b, a >> b, a <<< b (ASL), a >>> b (ASR)

  assign {cout, sum} = a + b + cin;
  assign test = cin ? 0 : 1; // if cin then 0 else 1
endmodule
