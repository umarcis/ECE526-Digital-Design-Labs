/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #3            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #3 Design of a circuit with different gates testbench	 ***  
***									 ***  
*** Filename: Lab3_1_tb.v      Created by Muhammad Umar, 02/26/2025      ***  
*** 									 ***  
*** This testbench simulates the Lab3_1 module, applying different input ***  
*** combinations while monitoring internal signals and displaying results*** 
*** with the $monitor system task. 					 ***
***************************************************************************/  


`timescale 1 ns / 100 ps // 0.5ns can be captured by applying this timescale


`define MONITOR_STR_1 "%d: in1 = %b, in2 = %b, | out = %b  , Internal Signals A1 = %b, A2 = %b, NT = %b"

module Lab3_1_with_delay_tb();
    reg in1, in2;
    wire out;
    
    Lab3_1_with_delay UUT(in1, in2, out);

    initial begin
        $monitor(`MONITOR_STR_1, $time, in1, in2, out, UUT.A1, UUT.A2, UUT.NT); // Accessing internal signals by providing instance name with "."
    end

    initial begin
        $vcdpluson; 

        #20 in1 = 1'b0; in2 = 1'b0;
        #20 in1 = 1'b0; in2 = 1'b1;
        #20 in1 = 1'b1; in2 = 1'b0;
        #20 in1 = 1'b1; in2 = 1'b1;

        #20 $finish;
    end
endmodule
