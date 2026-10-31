/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #5            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #5 Design 8bit Reloadable up counter with AASD Reset 	 ***
*** Synchronizer.						         ***  
***									 ***  
*** Filename: up_counter.v   	    Created by Muhammad Umar, 03/10/2025 ***  
*** 									 ***  
*** This module implements a logic circuit of up_counter with load and   ***  
*** and enable signal.	 						 ***  
***************************************************************************/ 


module up_counter (
    input wire clk,         
    input wire rst_n,       // Asynchronous active-low reset
    input wire enable,      // Synchronous active high enable
    input wire load,        // Synchronous active high load
    input wire [7:0] data,  
    output reg [7:0] count  // count output
);

    // Asynchronous reset and rest is synchronous because of AASD module  
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin   
            count <= 8'b0; // Reset the counter to 0
        end else if (enable) begin
            if (load) begin
                count <= data; // Load the data into the counter
            end else begin
                count <= count + 1; // Incrementing the counter when enable is active and load is 0.
            end
        end
    end

endmodule
