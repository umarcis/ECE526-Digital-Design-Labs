/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #8            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment#8 Sum of Products Circuit Hierarchical Design and Testing ***
***									 ***  
*** Filename: sop_top_tb_non_exhaustive.v 			         ***
*** 				Created by Muhammad Umar, 04/20/2025	 ***  
*** 									 ***  
*** This testbench applies a small set of carefully selected input       ***
*** vectors to verify the basic functionality of the hierarchical SOP    ***
*** design.                                                              ***
***************************************************************************/

`timescale 1ns/1ps

module sop_top_tb_non_exhaustive;

    parameter WIDTH = 4;

    reg clk;
    reg rst;
    reg [WIDTH-1:0] data0, data1, data2, data3;
    reg [WIDTH-1:0] coef0, coef1, coef2, coef3;
    wire [(2*WIDTH+1):0] sop_result;

    // DUT instantiation
    sop_top #(WIDTH) DUT (
        .clk(clk),
        .rst(rst),
        .data0(data0), .data1(data1),
        .data2(data2), .data3(data3),
        .coef0(coef0), .coef1(coef1),
        .coef2(coef2), .coef3(coef3),
        .sop_result(sop_result)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        $vcdpluson;
        clk = 0;
        rst = 1;
        #10 rst = 0;

        $display("\n=================== Starting Non-Exhaustive SOP Test ===================\n");
	$display("=============================================================================");
        $display("Time\tData Inputs\t\tCoef Inputs\tSOP Result");
	$display("=============================================================================\n\n");

        // Test cases with clear context
        apply_inputs(0, 0, 0, 0, 0, 0, 0, 0, "All zero input check");
        apply_inputs(1, 2, 3, 4, 4, 3, 2, 1, "Mix of increasing/decreasing values");
        apply_inputs(15, 15, 15, 15, 1, 1, 1, 1, "Max data input test");
        apply_inputs(1, 0, 0, 0, 15, 0, 0, 0, "Single active multiplier path");
        apply_inputs(8, 4, 2, 1, 1, 2, 4, 8, "Bit pattern test (shifting weights)");
        apply_inputs(15, 0, 15, 0, 0, 15, 0, 15, "Alternating pattern test");
        apply_inputs(7, 7, 7, 7, 7, 7, 7, 7, "Uniform mid-range values");
        apply_inputs(5, 10, 5, 10, 10, 5, 10, 5, "Crisscross mix pattern");
        apply_inputs(9, 6, 3, 0, 0, 3, 6, 9, "Descending and ascending combination");
        apply_inputs(1, 2, 3, 4, 1, 2, 3, 4, "Same sequence on both inputs");

        $display("\n=================================== Non Exhausted Test Completed =================================== \n");
        $finish;
    end

    // Stimulus task with message
    task apply_inputs;
        input [WIDTH-1:0] d0, d1, d2, d3;
        input [WIDTH-1:0] c0, c1, c2, c3;
        input [255:0] message;

        begin
	    $display("=========================================================================");
            $display("Test: %0s", message);
	    $display("=========================================================================");

            data0 = d0; data1 = d1; data2 = d2; data3 = d3;
            coef0 = c0; coef1 = c1; coef2 = c2; coef3 = c3;

            @(posedge clk);  // Register data
            @(posedge clk);  // Wait for result to stabilize

            $display("%0t\t%d %d %d %d\t\t%d %d %d %d\t= %d\n",
                $time,
                data0, data1, data2, data3,
                coef0, coef1, coef2, coef3,
                sop_result
            );
        end
    endtask

endmodule
