/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #8            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment#8 Sum of Products Circuit Hierarchical Design and Testing ***
***									 ***  
*** Filename: register.v 	Created by Muhammad Umar, 04/20/2025	 ***  
*** 									 ***  
*** This module implements a parameterized register with synchronous     ***
*** reset. It stores a WIDTH-bit input on the rising clock edge and clears***
*** the output when reset is asserted.                                   ***
***************************************************************************/

`timescale 1ns/1ps

module register #(parameter WIDTH = 4) (
    input wire clk,
    input wire rst,
    input wire [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);
    always @(posedge clk) begin
        if (rst)
            q <= 0;
        else
            q <= d;
    end
endmodule
