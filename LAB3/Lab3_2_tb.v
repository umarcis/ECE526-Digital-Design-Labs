/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #3            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #3 Design of a circuit with different gates testbench	 ***  
***									 ***  
*** Filename: Lab3_2_tb.v      Created by Muhammad Umar, 02/26/2025      ***  
*** 									 ***  
*** This testbench simulates the Lab3_2 module, applying different input ***  
*** combinations while monitoring internal signals and displaying results*** 
*** with the $monitor system task. 					 ***
***************************************************************************/ 


`timescale 1 ns / 100 ps // 0.1ns can be captured by selecting this timescale


`define MONITOR_STR_1 "%d: in1 = %b, in2 = %b, | out = %b  | Internal Signals A1 = %b, A2 = %b, O1 = %b, NT = %b"

module Lab3_2_tb();
    reg in1, in2;
    wire out;
    
    Lab3_2 UUT(in1, in2, out);

    initial begin
        $monitor(`MONITOR_STR_1, $time, in1, in2, out, UUT.A1, UUT.A2,UUT.O1, UUT.NT);
    end

    initial begin
        $vcdpluson; 
	
	// All possible combinations applied here without x and z conditions

        #20 in1 = 1'b0; in2 = 1'b0;  
        #20 in1 = 1'b0; in2 = 1'b1;
        #20 in1 = 1'b1; in2 = 1'b0;
        #20 in1 = 1'b1; in2 = 1'b1;

        #20 $finish;
    end
endmodule
