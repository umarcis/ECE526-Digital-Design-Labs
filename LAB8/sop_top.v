/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #8            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment#8 Sum of Products Circuit Hierarchical Design and Testing ***
***									 ***  
*** Filename: sop_top.v 	Created by Muhammad Umar, 04/20/2025	 ***  
*** 									 ***  
*** This module implements the top-level Sum of Products circuit.        ***
*** It sums the outputs of two SOP blocks and produces a (2*WIDTH+1)-bit ***
*** final result.                                                        ***
***************************************************************************/

`timescale 1ns/1ps

module sop_top #(parameter WIDTH = 4)(
    input wire clk,
    input wire rst,
    input wire [WIDTH-1:0] data0, data1, data2, data3,
    input wire [WIDTH-1:0] coef0, coef1, coef2, coef3,
    output wire [(2*WIDTH+1):0] sop_result
);
    wire [(2*WIDTH):0] sum0, sum1;
    wire [(2*WIDTH+1):0] final_sum;

    // Two SOP blocks
    sop_block #(WIDTH) sb0 (
        .clk(clk), .rst(rst),
        .data0(data0), .data1(data1),
        .coef0(coef0), .coef1(coef1),
        .sum_out(sum0)
    );

    sop_block #(WIDTH) sb1 (
        .clk(clk), .rst(rst),
        .data0(data2), .data1(data3),
        .coef0(coef2), .coef1(coef3),
        .sum_out(sum1)
    );

    // Final adder
    adder #(2*WIDTH+1) final_adder (
        .a(sum0), .b(sum1), .sum(final_sum)
    );

    assign sop_result = final_sum;
endmodule
