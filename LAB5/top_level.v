/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #5            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #5 Design 8-bit Reloadable up counter with AASD Reset 	 ***
*** Synchronizer.						         ***  
***									 ***  
*** Filename: top_level.v 	    Created by Muhammad Umar, 03/10/2025 ***  
*** 									 ***  
*** This module implements a logic circuit of Asynchronous Assert        ***  
*** Synchronous Deassert (AASD) and up-counter module by instantiating 	 ***
*** both the modules, where an intermediate wire sync_rst_n will get the ***
*** synchroized reset signal from reset_synchronizer module and then it  ***
*** will be given to up_counter module				         ***  
***************************************************************************/

module top_level (
    input wire clk,           
    input wire async_rst_n,   // Asynchronous active low reset
    input wire enable,        // Synchronous active high enable
    input wire load,          // Synchronous active high load
    input wire [7:0] data,    
    output wire [7:0] count   // count output
);

    wire sync_rst_n; // Synchronized reset signal from AASD module

    // Instantiate the reset synchronizer
    reset_synchronizer sync_reset (
        .clk(clk),
        .async_rst_n(async_rst_n),
        .sync_rst_n(sync_rst_n)
    );

    // Instantiate the counter
    up_counter counter (
        .clk(clk),
        .rst_n(sync_rst_n),
        .enable(enable),
        .load(load),
        .data(data),
        .count(count)
    );

endmodule