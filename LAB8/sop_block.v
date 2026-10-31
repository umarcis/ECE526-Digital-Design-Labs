/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #8            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment#8 Sum of Products Circuit Hierarchical Design and Testing ***
***									 ***  
*** Filename: sop_block.v 	Created by Muhammad Umar, 04/20/2025	 ***  
*** 									 ***  
*** This module implements a hierarchical Sum of Products block.         ***
*** It multiplies two pairs of data and coefficients, sums the products, ***
*** and outputs a (2*WIDTH)-bit result.                                  ***
***************************************************************************/

`timescale 1ns/1ps

module sop_block #(parameter WIDTH = 4)(
    input wire clk,
    input wire rst,
    input wire [WIDTH-1:0] data0, data1,
    input wire [WIDTH-1:0] coef0, coef1,
    output wire [(2*WIDTH):0] sum_out
);
    wire [WIDTH-1:0] reg_out0, reg_out1;
    wire [(2*WIDTH)-1:0] prod0, prod1;
    wire [(2*WIDTH):0] adder_out;

    // Registers
    register #(WIDTH) r0 (.clk(clk), .rst(rst), .d(data0), .q(reg_out0));
    register #(WIDTH) r1 (.clk(clk), .rst(rst), .d(data1), .q(reg_out1));

    // Multipliers
    multiplier #(WIDTH) m0 (.a(reg_out0), .b(coef0), .p(prod0));
    multiplier #(WIDTH) m1 (.a(reg_out1), .b(coef1), .p(prod1));

    // Adder (width = 2*WIDTH)
    adder #(2*WIDTH) a0 (.a(prod0), .b(prod1), .sum(adder_out));

    assign sum_out = adder_out;
endmodule
