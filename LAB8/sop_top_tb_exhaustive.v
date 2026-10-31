/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #8            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment#8 Sum of Products Circuit Hierarchical Design and Testing ***
***									 ***  
*** Filename: sop_top_tb_exhaustive_randomized.v 			 ***
*** 				Created by Muhammad Umar, 04/20/2025	 ***  
*** 									 ***  
*** This testbench verifies the SOP design by applying 1,000,000         ***
*** randomized input combinations and comparing the DUT output against   ***
*** a reference model.                                                   ***
***************************************************************************/


`timescale 1ns/1ps

module sop_top_tb_exhaustive_randomized;

    parameter WIDTH = 4;
    integer count = 0;
    integer total_tests;
    reg error_flag;  // Error flag to track mismatch

    reg clk;
    reg rst;
    reg [WIDTH-1:0] data0, data1, data2, data3;
    reg [WIDTH-1:0] coef0, coef1, coef2, coef3;
    wire [(2*WIDTH+1):0] sop_result;

    // Expected reference output
    reg [(2*WIDTH+1):0] expected_result;

    // Instantiate the DUT
    sop_top #(WIDTH) DUT (
        .clk(clk), .rst(rst),
        .data0(data0), .data1(data1),
        .data2(data2), .data3(data3),
        .coef0(coef0), .coef1(coef1),
        .coef2(coef2), .coef3(coef3),
        .sop_result(sop_result)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;

        $vcdpluson;

        total_tests = 1000000;  // Randomize 100,0000 test vectors
        error_flag = 0;

        $display("\n===== Starting Randomized Exhaustive Test (d0,d1,d2,d3,c0,c1,c2,c3 varied in all transaction) =====\n");

        $monitor("%0t: Inputs (%d*%d) + (%d*%d) + (%d*%d) + (%d*%d) => DUT: %d, Expected: %d",
                 $time,
                 data0, coef0, data1, coef1, data2, coef2, data3, coef3,
                 sop_result, expected_result);

        $monitoroff;

        repeat (total_tests) begin
            // Randomize inputs
            data0 = $random % 16;
            data1 = $random % 16;
            data2 = $random % 16;
	    data3 = $random % 16;
            coef0 = $random % 16;
            coef1 = $random % 16;
            coef2 = $random % 16;
            coef3 = $random % 16;

	    expected_result = (data0*coef0) + (data1*coef1) + (data2*coef2) + (data3*coef3);

            @(posedge clk);
            @(posedge clk);

            

            count = count + 1;

            `ifdef FORCE_ERROR
            if (count > (total_tests * 3) / 4)
                expected_result = expected_result + 1;  // Force error injection
            `endif

            // Control monitor output
            if (count <= 12 || count >= (total_tests - 12))
                $monitoron;
            else
                $monitoroff;

            // Compare
            if (sop_result !== expected_result) begin
                $display("\nERROR at time %0t: Mismatch Detected!", $time);
                $display("Inputs: (%d*%d) + (%d*%d) + (%d*%d) + (%d*%d)",
                          data0, coef0, data1, coef1, data2, coef2, data3, coef3);
                $display("Expected: %d, Got: %d", expected_result, sop_result);
                error_flag = 1;
		@(posedge clk);
		@(posedge clk);
                $finish;
            end
		else begin
                $display("Transaction Passed at time %0t  Expected: %d, Got: %d", $time, expected_result, sop_result);
            end
        end

        // Final result
        if (error_flag == 0) begin
            $display("\n===== TEST PASSED: All randomized vectors matched correctly! =====\n");
        end
        else begin
            $display("\n===== TEST FAILED: Errors detected during simulation. =====\n");
        end

        $finish;
    end

endmodule
