/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #8            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment#8 Sum of Products Circuit Hierarchical Design and Testing ***
***									 ***  
*** Filename: multiplier.v 	Created by Muhammad Umar, 04/20/2025	 ***  
*** 									 ***  
*** This module implements a parameterized multiplier that computes the  ***
*** product of two WIDTH-bit inputs, producing a (2*WIDTH)-bit output.   ***
***************************************************************************/

`timescale 1ns/1ps

module multiplier #(parameter WIDTH = 4) (
    input wire [WIDTH-1:0] a,
    input wire [WIDTH-1:0] b,
    output wire [(2*WIDTH)-1:0] p
);
    assign p = a * b;
endmodule
