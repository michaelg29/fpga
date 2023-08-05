// Copyright (C) 2021  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// *****************************************************************************
// This file contains a Verilog test bench template that is freely editable to  
// suit user's needs .Comments are provided in each section to help the user    
// fill out necessary details.                                                  
// *****************************************************************************
// Generated on "08/05/2023 11:36:53"
                                                                                
// Verilog Test Bench template for design : dut_top
// 
// Simulation tool : ModelSim (Verilog)
// 

`timescale 1 ps/ 1 ps
`define CLK_PER_PS 1000


module tb_top();

import test_pkg::*;

localparam time CLK_PER = `CLK_PER_PS * 1ps;
localparam time HLF_CLK_PER = CLK_PER / 2;

// constants
logic w_clk_dut = 1'b0;
logic w_rst_n = 1'b1;

// test vector input registers
logic [7:0] a = '0;
logic [7:0] b = '0;
// wires                                               
wire carry_out;
wire [7:0] sum;

// assign statements
adder DUT (
// port map - connection between master ports and signals/registers
	.i_clk(w_clk_dut),
    .i_rst_n(w_rst_n),
	.i_a(a),
	.i_b(b),
	.o_c(carry_out),
	.o_s(sum)
);

always #(HLF_CLK_PER) begin
	w_clk_dut <= ~w_clk_dut;
end

initial begin
    test_class::print_hello();
	// code that executes only once
	$display("Running testbench");
	// insert code here --> begin
    w_rst_n <= 1'b0;
    #(20*CLK_PER);
    w_rst_n <= 1'b1;
    $display("Done with reset");
    
    $display("Driving inputs");
	a <= 8'hAB;
	b <= 8'hBC;
end

endmodule

