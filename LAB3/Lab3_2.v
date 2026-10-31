/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #3            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #3 Design of a circuit with different gates               ***  
***									 ***  
*** Filename: Lab3_2.v         Created by Muhammad Umar, 02/26/2025      ***  
*** 									 ***  
*** This module implements a logic circuit with NOT, AND, OR and NAND    ***  
*** gates, each having specified delays to simulate gate-level timing.   ***  
***************************************************************************/  

`timescale 1 ns / 100 ps


`define PRIMARY_OUT     5   // ns (primary outputs)
`define FAN_OUT_1       0.5   // ns (one output fanout)
`define FAN_OUT_2       1   // ns (two output fanout)
`define FAN_OUT_3       1.5 // ns (three output fanout)
`define TIME_DELAY_1    1   // ns (one input gates)
`define TIME_DELAY_2    2   // ns (two input gates)
`define TIME_DELAY_3    4   // ns (three input gates)
`define TIME_DELAY_4    5   // ns (four input gates)

module Lab3_2 (in1, in2, out1);
    input in1, in2;
    output out1;

    wire NT, A1, A2, O1;

    not  #(`TIME_DELAY_1 + `FAN_OUT_3)  NOT1(NT, in1);
    and  #(`TIME_DELAY_2 + `FAN_OUT_1)  AND1(A1, in2, in1);
    and  #(`TIME_DELAY_2 + `FAN_OUT_2)  AND2(A2, in1, NT);
    or   #(`TIME_DELAY_2 + `FAN_OUT_1)  OR1(O1, NT, A2);  // addition of OR gate, output will be stored in "O1" declared above
    nand #(`TIME_DELAY_4 + `PRIMARY_OUT) NAND1(out1, NT, A1, A2, O1);
endmodule
