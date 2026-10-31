/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #4            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #4 Design 8bit register with instances of Mux and DFF     ***  
***									 ***  
*** Filename: dff.v   		    Created by Muhammad Umar, 03/07/2025 ***  
*** 									 ***  
*** This module implements a logic circuit of simple asynchronous        ***  
*** D Flipflop   							 ***  
***************************************************************************/  

`timescale 1 ns / 100 ps

module dff (
    input clk,       
    input rst_n,     // active low reset
    input d,         // data to the dff
    output reg q     // output must be reg when using in always block
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)      
            q <= 1'b0;   // Reset output to 0
        else
            q <= d;      // stores value on the positive edge of the clock
    end

endmodule
