/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #3            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #3 Different gates logical circuit and SR Latch testbench ***  
***									 ***  
*** Filename: Lab3_3_SR_Latch_tb.v   Created by Muhammad Umar, 02/26/2025***  
*** 									 ***  
*** This testbench verifies the functionality of the SR latch by 	 ***  
*** applying different input combinations and monitoring the outputs     *** 
*** with different system tasks like monitor, strobe and display. 	 ***
***************************************************************************/ 



`timescale 1ns/100ps  // Timescale for delay observation

module Lab3_3_SR_Latch_tb();
    reg s0, s1, r0, r1;
    wire Q, Qnot;

    // DUT Instantiation
    Lab3_3_SR_Latch UUT(Q, Qnot, s0, s1, r0, r1);

    // Monitor signal changes display whenever each one changed
    initial 
        $monitor("Time %t: s0=%b s1=%b r0=%b r1=%b | Q=%b Qnot=%b", 
                 $time, s0, s1, r0, r1, Q, Qnot);

    initial begin

	$vcdpluson;

	// Apply all 16 possible input combinations
        
    	#20  s0=0; s1=0; r0=0; r1=0;  // Invalid (Both Q and Qnot = 1)
    	#20  s0=0; s1=0; r0=0; r1=1;  // Invalid
    	#20  s0=0; s1=0; r0=1; r1=0;  // Invalid
    	#20  s0=0; s1=0; r0=1; r1=1;  // Invalid

    	#20  s0=0; s1=1; r0=0; r1=0;  // Invalid 
    	#20  s0=0; s1=1; r0=0; r1=1;  // Invalid (Simultaneous Set & Reset occur here)
    	#20  s0=0; s1=1; r0=1; r1=0;  // Invalid (Both Q and Qnot = 1)
    	#20  s0=0; s1=1; r0=1; r1=1;  // Correct Set  (Q=1, Qnot=0)

    	#20  s0=1; s1=0; r0=0; r1=0;  // Invalid 
    	#20  s0=1; s1=0; r0=0; r1=1;  // Set (Q=1, Qnot=0)
    	#20  s0=1; s1=0; r0=1; r1=0;  // Invalid (Both Q and Qnot = 1)
    	#20  s0=1; s1=0; r0=1; r1=1;  // Set  (Q=1, Qnot=0)

    	#20  s0=1; s1=1; r0=0; r1=0;  // Reset (Q=0, Qnot=1)
    	#20  s0=1; s1=1; r0=0; r1=1;  // Reset (Q=0, Qnot=1)
    	#20  s0=1; s1=1; r0=1; r1=0;  // Reset (Q=0, Qnot=1)
    	#20  s0=1; s1=1; r0=1; r1=1;  // Hold  (Q and Qnot remain unchanged)



        // Demonstrate usage of different output system tasks

        // $display prints immediately with a newline
        #5 $display("Time %t: Test Completed. Final state: Q=%b Qnot=%b", 
                   $time, Q, Qnot);

        // $write prints immediately without a newline
        #5 $write("End of Simulation at Time %t. ", $time);
        $write("Final Outputs: Q=%b, Qnot=%b\n", Q, Qnot);

        // $strobe prints at the end of the current time step
        #5 $strobe("At Time %t: Final Outputs - Q=%b, Qnot=%b", 
                  $time, Q, Qnot);

        #10 $finish; 
    end
endmodule
