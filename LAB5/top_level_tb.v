/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #5            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #5 Design 8-bit Reloadable up counter with AASD Reset 	 ***
*** Synchronizer.						         ***  
***									 ***  
*** Filename: top_level_tb.v 	    Created by Muhammad Umar, 03/10/2025 ***  
*** 									 ***  
*** This module implements a testbench of logic circuit of Top Level     ***
*** in which we have identified all the cases 			         ***  
 
***************************************************************************/


module top_level_tb;
    reg clk;               
    reg async_rst_n;       
    reg enable;            
    reg load;              
    reg [7:0] data;       
    wire [7:0] count;     

    // (a) Instantiating the top-level module
    top_level uut (
        .clk(clk),
        .async_rst_n(async_rst_n),
        .enable(enable),
        .load(load),
        .data(data),
        .count(count)
    );

    // (b) Clock generation of 20 ns period.
    initial begin
        clk = 0;
        forever #10 clk = ~clk; 
    end

    // Test sequence
    initial begin
	$vcdpluson;

	$display("\n************************************************************************");
        $display("Initializing signals and asserting asynchronous reset\n");
	$display("************************************************************************\n");
        async_rst_n = 1'b0;
        enable = 1'b0;
        load = 1'b0;
        data = 8'b0;
        
	$display("************************************************************************");
        #15 $display("Deasserting reset before positive edge to check async behavior\n");
	$display("************************************************************************\n");

        async_rst_n = 1'b1;

        // (d) Enable the counter and let it count to 8
	$display("************************************************************************");
        $display("Enabling counter and waiting for it to count to 8\n");
	$display("************************************************************************\n");
        enable = 1'b1;
        repeat (11) @(posedge clk);

        // (e) Load 240 into the counter when it reaches 8
	$display("************************************************************************");
        $display("Loading 240 into counter\n");
	$display("************************************************************************\n");
        data = 8'd240;
        load = 1'b1;
        @(posedge clk) load = 1'b0;

        // Let the counter count until it rolls over
	$display("************************************************************************");
        $display("Letting counter count until it rolls over\n");
	$display("************************************************************************\n");
        repeat (20) @(posedge clk);

        // (f) Demonstrate reset override
	$display("************************************************************************");
        #5 $display("Asserting reset between edges to check immediate effect\n");
	$display("************************************************************************\n");
        async_rst_n = 1'b0;
        #15 $display("Deasserting reset before next positive edge\n");
        async_rst_n = 1'b1;

        // (g) Demonstrate enable functionality
	$display("************************************************************************");
        $display("Disabling counter to check enable functionality\n");
	$display("************************************************************************\n");
        enable = 1'b0;
        repeat (4) @(posedge clk);
        $display("Enabling counter again\n");
        enable = 1'b1;

        repeat (5) @(posedge clk);
	$display("************************************************************************");
        $display("			Simulation Ended");
	$display("************************************************************************\n");
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("\n Time = %0t | Reset = %b | Enable = %b | Load = %b | Data = %d | Count = %d\n",
                 $time, async_rst_n, enable, load, data, count);
    end
endmodule
