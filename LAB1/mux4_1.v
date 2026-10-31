/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #1 		     Muhammad Umar, Spring, 2025 ***  
*** 									 ***  
*** Experiment #1 Familiarization with Linux and Synopsys VCS 		 ***  
***									 ***  
*** Filename: mux4_1.v 		   Created by Muhammad Umar, 02/04/2025  ***  
*** 		 					                 ***  
*** This 4-to-1 multiplexer (mux4_1) selects one of four inputs 	 ***
*** (a, b, c, d) based on the two selection signals (s0, s1). It uses    ***
*** NOT, AND, and OR gates to implement the selection logic		 ***

***************************************************************************/ 



`timescale 1 ns / 1 ns  // Define the time unit (1 ns) and time precision (1 ns)

module mux4_1(out, a, b, c, d, s0, s1);

	output out;
	input a, b, c, d, s0, s1;  	    // 4 input data signals
	wire s0_n, s1_n, T1, T2, T3, T4;   // 2-bit selection signals and Internal wires

	not (s0_n, s0), (s1_n, s1);	// Generate inverted selection signals
	and (T1, a, s0_n, s1_n),   // T1 is active when s0 = 0, s1 = 0 (selects 'a')
	    (T2, b, s0_n, s1), 	   // T2 is active when s0 = 0, s1 = 1 (selects 'b')
	    (T3, c, s0, s1_n),     // T3 is active when s0 = 1, s1 = 0 (selects 'c')
	    (T4, d, s0, s1);  	   // T4 is active when s0 = 1, s1 = 1 (selects 'd')
	or (out, T1, T2, T3, T4);  

endmodule


