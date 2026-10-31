/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #4            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #4 Design 8bit register with instances of Mux and DFF     ***  
***									 ***  
*** Filename: MUX2_1.v   	    Created by Muhammad Umar, 03/07/2025 ***  
*** 									 ***  
*** This module implements a logic circuit of Multiplexer 2x1 wit        ***  
*** required delays.   							 ***  
***************************************************************************/ 


`timescale 1 ns / 100 ps

`define PRIMARY_OUT     5   // ns (primary outputs)
`define FAN_OUT_1       0.5 // ns (one output fanout)
`define TIME_DELAY_1    1   // ns (one input gates)
`define TIME_DELAY_2    2   // ns (two input gates)


module MUX2_1(OUT, A, B, SEL);
    // Port declarations
    output OUT;
    input A, B, SEL;

    // Internal variable declarations
    wire A1, B1, SEL_N;

    // The netlist with delays
    not  #(`TIME_DELAY_1 + `FAN_OUT_1) NOT1(SEL_N, SEL);       // NOT gate delay
    and  #(`TIME_DELAY_2 + `FAN_OUT_1)  AND1(A1, A, SEL_N);     // AND gate with 2 inputs
    and  #(`TIME_DELAY_2 + `FAN_OUT_1)  AND2(B1, B, SEL);       // AND gate with 2 inputs
    or   #(`TIME_DELAY_2 + `PRIMARY_OUT)  OR1(OUT, A1, B1);      // OR gate with 2 input and final output

endmodule
