/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #1 		     Muhammad Umar, Spring, 2025 ***  
*** 									 ***  
*** Experiment #2 Design a Full Adder			 		 ***  
***									 ***  
*** Filename: half_adder 	   Created by Muhammad Umar, 02/13/2025  ***  
*** 		 					                 ***  
*** This half adder (half_adder.v) performs binary addition on two 	 ***
*** single-bit inputs (a, b) and produces a sum (s) and a carry (c). 	 ***
*** It is implemented using a single XOR gate for the sum calculation    ***
*** and a single AND gate for the carry.  				 ***

***************************************************************************/ 



`timescale 1 ns / 1 ns  // Define the time unit (1ns) and time precision (1 ns)


module half_adder(
    input a,  // Input 'a'
    input b,  // Input 'b'
    output s, // Output 's' (Sum)
    output c  // Output 'c' (Carry)
);

    // Gate-level modeling
    xor (s, a, b); // XOR gate for sum
    and (c, a, b); // AND gate for carry

endmodule
