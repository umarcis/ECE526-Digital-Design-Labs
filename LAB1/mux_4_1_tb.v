/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #1 		     Muhammad Umar, Spring, 2025 ***  
*** 									 ***  
*** Experiment #1 Familiarization with Linux and Synopsys VCS 		 ***  
***									 ***  
*** Filename: mux_4_1_tb.v 	   Created by Muhammad Umar, 02/04/2025  ***  
*** 		 					                 ***  
*** This 4-to-1 multiplexer (mux4_1) testbench used to test the design	 ***
*** by instantiating design module in this file and apply stimulus to    ***
*** the design and observe the output of design    			 ***

***************************************************************************/ 


`timescale 1 ns / 1 ns

module mux4_1_tb();
  
	reg A, B, C, D, SEL0, SEL1;  // declaring input signals to apply stimulus
	wire OUT;		     // declaring OUT as a wire for just observing output

	mux4_1 UUT(OUT, A, B, C, D, SEL0, SEL1);  // instantiation of module takes place here

	initial
  	$monitorb ("%d OUT= %b A= %b B= %b C= %b D= %b SEL0= %b SEL= %b", 
              $time, OUT, A, B, C, D, SEL0, SEL1); 	// observing the output of applied stimulus

	initial begin
  	$vcdpluson;
  	A=1; B=1; C=1; D=1; SEL0=1'bx; SEL1=1'bx;  // applying stimulus at zero time 
  	#10 A=0; B=1; C=0; D=1; SEL0=0; SEL1=0;	   // applying another set of input after 10nsec
  	#20 SEL0=0; SEL1=1;
  	#20 SEL0=1; SEL1=0;
  	#20 SEL0=1; SEL1=1;
  	#10 A=1; B=0; C=1; D=0; SEL0=0; SEL1=0;
  	#20 SEL0=0; SEL1=1;
  	#20 SEL0=1; SEL1=0;
  	#20 SEL0=1; SEL1=1;
  	#20 $finish;
	end

endmodule

