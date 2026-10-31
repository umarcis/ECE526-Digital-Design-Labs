/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #3            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #3 Design of a circuit with different gates and SR Latch  ***  
***									 ***  
*** Filename: Lab3_3.v         Created by Muhammad Umar, 02/26/2025      ***  
*** 									 ***  
*** This module implements an SR latch using NAND gates with specified   ***  
*** delays to observe timing effects.    			         ***  
***************************************************************************/  


`timescale 1ns/100ps  // Timescale for delay observation

`define PRIMARY_OUT     5   // ns (primary outputs)
`define FAN_OUT_2       1   // ns (two output fanout)
`define TIME_DELAY_3    4   // ns (three input gates)



module Lab3_3_SR_Latch(
    output Q,		// Output for SR latch 
    output Qnot,	// invert of Q
    input s0, 
    input s1, 
    input r0, 
    input r1
    );

    nand  #(`TIME_DELAY_3 + `PRIMARY_OUT) NAND1(Q, s0, s1, Qnot);  // 3-input NAND gate for Q
    nand  #(`TIME_DELAY_3 + `PRIMARY_OUT) NAND2(Qnot, r0, r1, Q);  // 3-input NAND gate for Qnot

endmodule
