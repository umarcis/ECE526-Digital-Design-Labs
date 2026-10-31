/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #2            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #2 Design a Full Adder			                 ***  
***									 ***  
*** Filename: half_adder_tb.v      Created by Muhammad Umar, 02/13/2025  ***  
*** 									 ***  
*** This testbench (half_adder_tb) is used to test the half adder design.***  
*** It applies all possible input combinations to the half adder module  ***  
*** and monitors the sum and carry outputs.                              ***  
***************************************************************************/  

`timescale 1 ns / 1 ns  

module half_adder_tb();  

    // Declare input signals for testbench 
    reg a, b;       // Input signals  

    // Declare output signals to observe results
    wire s, c;      // Output signals  

    // Instantiate the half adder module  
    half_adder dut (  
        .a(a),  
        .b(b),  
        .s(s),  
        .c(c)  
    );  

    // Monitor the values of inputs and outputs during simulation  
    initial  
        $monitor("%d a = %b, b = %b, s = %b, c = %b",  
                 $time, a, b, s, c);  

    // Applying stimulus here
    initial begin  
        $vcdpluson;	// Enable waveform dump for debugging  
       
        // Apply different test cases with delays
        a = 0; b = 0; #10;  
        a = 0; b = 1; #10;  
        a = 1; b = 0; #10;  
        a = 1; b = 1; #10;
  
        $finish;  
    end  

endmodule 