/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #5            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #5 Design 8-bit Reloadable up counter with AASD Reset 	 ***
*** Synchronizer.						         ***  
***									 ***  
*** Filename: reset_synchronizer.v  Created by Muhammad Umar, 03/10/2025 ***  
*** 									 ***  
*** This module implements a logic circuit of Asynchronous Assert        ***  
*** Synchronous Deassert (AASD), When reset is 0 then it will reset the  ***
*** circuit at the same time, when reset is 1, the circuit will get the  ***
*** reset signal stable on positive edge of clock cycle to avoid 	 ***
*** metastability condition						 ***  
***************************************************************************/

module reset_synchronizer (
    input wire clk,        
    input wire async_rst_n, // Asynchronous active low reset
    output wire sync_rst_n  // Synchronized active low reset
);

    reg rst_ff1, rst_ff2; // Two flip-flops used for synchronization

    always @(posedge clk or negedge async_rst_n) begin
        if (!async_rst_n) begin
            rst_ff1 <= 1'b0;
            rst_ff2 <= 1'b0;
        end else begin
            rst_ff1 <= 1'b1;
            rst_ff2 <= rst_ff1;
        end
    end

    assign sync_rst_n = rst_ff2; // Synchronized reset output

endmodule