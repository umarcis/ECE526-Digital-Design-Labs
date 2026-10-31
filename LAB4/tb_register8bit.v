/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #4            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #4 Design 8bit register with instances of Mux and DFF     ***  
***									 ***  
*** Filename: tb_register8bit.v     Created by Muhammad Umar, 03/07/2025 ***  
*** 									 ***  
*** This module implements a logic circuit of register with instances    ***  
*** of Mux and D Flipflops.  						 ***  
***************************************************************************/ 

`timescale 1ns / 100ps

module tb_register8bit;
    
    reg clk, rst_n, ena;
    reg [7:0] data;
    wire [7:0] r;

    // Instantiate DUT (Device Under Test)
    register8bit dut (
        .clk(clk),
        .rst_n(rst_n),
        .ena(ena),
        .data(data),
        .r(r)
    );

    // Clock Generation: 10 ns period (100 MHz)
    always #5 clk = ~clk;

    initial begin
	$vcdpluson;
        // Initialize Signals
        clk = 0;
        rst_n = 0;    // Active-low reset
        ena = 0;
        data = 8'h00;

	$display("******************************************************************");
	$display("TEST STARTED - Reset Applied");
	$display("******************************************************************");

        $display("\n");
        repeat (2) @(posedge clk);  // Wait for two clock cycles
        rst_n = 1;  // Release reset


        // Test Case 1: Hold previous data when ena = 0
	$display("******************************************************************");
	$display("Test Case 1: Hold previous data when ena = 0");
	$display("******************************************************************");

	ena = 0;
        data = 8'h8a;  // Set data
        repeat (2) @(posedge clk);
        $display("TEST Case 1: ena = %b, Expected = 00, Observed=%h\n",ena, r);

	
	// Test Case 2 : Write new data when ena = 1
	$display("******************************************************************");
	$display("Test Case 2 : Write new data when ena = 1");
	$display("******************************************************************");
	
        ena = 1;
        repeat (2) @(posedge clk);
	$display("TEST Case 2: ena = %b, Expected = 8a, Observed=%h\n", ena, r);


	// Test Case 3: Check if data holds when ena = 0
	$display("******************************************************************");
	$display("Test Case 3: Check if data holds when ena = 0");
	$display("******************************************************************");

        ena = 0;
        data = 8'b1100_0011; // Change input data but should not be stored
        repeat (1) @(posedge clk);
        $display("TEST Case 3: ena = %b, Expected = 8a, Observed=%h\n", ena, r);



	
	// Test Case 4: Write new data with ena = 1
	$display("******************************************************************************************");
	$display("Test Case 4: Write new data with ena = 1, it should reflect on the upcoming positive edge");
	$display("******************************************************************************************");

        ena = 1;
        data = 8'b1111_1111;
        repeat (2) @(posedge clk);
        $display("TEST Case 4: ena=1, Expected= ff, Observed=%h\n", r);



	// Test Case 5: Reset During Operation
	$display("******************************************************************");
	$display("Test Case 5: Reset During Operation");
	$display("******************************************************************");
	
        rst_n = 0;
        repeat (2) @(posedge clk);
        $display("TEST Case 5: Reset Applied, Expected=00, Observed=%h\n", r);

	

	// Test Case 6: clock period is shorter than the critical path delay.
        $display("**********************************************************************************");
        $display("Test Case 6: clock period is shorter than the critical path delay which is 14ns.");
        $display("**********************************************************************************");

        rst_n = 1;  // Release reset
        ena = 1;
        data = 8'haa;  // Load new data
	// Critical path delay is 14 ns, so this should cause timing violations and require 14ns minumum 
        repeat (1) @(posedge clk);
        $display("TEST Case 6: ena=1, Expected= aa, Observed=%h\n", r);

        $display("TEST COMPLETED\n");
        $finish;
    end

    // Monitor Outputs
    initial begin
        $monitor("Time=%0t | rst_n=%b | ena=%b | data=%h | r=%h\n", $time, rst_n, ena, data, r);
    end

endmodule
