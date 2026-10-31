/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #2            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #2 Design a Full Adder			                 ***  
***									 ***  
*** Filename: full_adder.v         Created by Muhammad Umar, 02/13/2025  ***  
*** 									 ***  
*** This full adder (full_adder) is implemented using two half adders.   ***  
*** It computes the sum and carry-out of three binary inputs A, B, and C.***  
***************************************************************************/  

`timescale 1 ns / 1 ns  

module full_adder(
    input A,          // Input bit A  
    input B,          // Input bit B  
    input C,          // Input carry-in  
    output Sum,       // Output sum  
    output Carry_out  // Output carry-out  
);

    // Internal signals  
    wire sum1, carry1, carry2;

    // First half adder (A, B)  
    half_adder HA1 (
        .a(A),  
        .b(B),  
        .s(sum1),  
        .c(carry1)  
    );

    // Second half adder (sum1, C)  
    half_adder HA2 (
        .a(sum1),  
        .b(C),  
        .s(Sum),  
        .c(carry2)  
    );

    // OR gate to calculate carry-out  
    or OR1 (Carry_out, carry1, carry2);

endmodule  
