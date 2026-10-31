/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #8            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment#8 Sum of Products Circuit Hierarchical Design and Testing ***
***									 ***  
*** Filename: adder.v 		Created by Muhammad Umar, 04/20/2025	 ***  
*** 									 ***  
*** This module implements a parameterized adder that sums two WIDTH-bit ***
*** inputs and outputs a (WIDTH+1) bit result to handle overflow.        ***
***************************************************************************/

`timescale 1ns/1ps

module adder #(parameter WIDTH = 4) (
    input wire [WIDTH-1:0] a,
    input wire [WIDTH-1:0] b,
    output wire [WIDTH:0] sum
);
    assign sum = a + b;
endmodule
