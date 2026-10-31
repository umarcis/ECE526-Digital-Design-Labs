/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #2            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #2 Design a Full Adder			                 ***  
***									 ***  
*** Filename: tb_full_adder.v      Created by Muhammad Umar, 02/13/2025  ***  
*** 									 ***  
*** This testbench (tb_full_adder) tests the full adder design. It       ***  
*** applies all possible input combinations and verifies Sum & Carry_out.***  
***************************************************************************/  

`timescale 1 ns / 1 ns  

module tb_full_adder();  

    // Declaring input signals for the testbench  
    reg Data_in_A;  
    reg Data_in_B;  
    reg Data_in_C;  

    // Declaring output signals to observe the results  
    wire Data_out_Sum;  
    wire Data_out_Carry;  

    // Instantiate the full adder module and mapping the input and outputs 
    full_adder dut (  
        .A(Data_in_A),  
        .B(Data_in_B),  
        .C(Data_in_C),  
        .Sum(Data_out_Sum),  
        .Carry_out(Data_out_Carry)  
    );  

    // Monitor the values of inputs and outputs during simulation  
    initial  
        $monitor("%d A = %b, B = %b, C = %b, Sum = %b, Carry = %b",  
                 $time, Data_in_A, Data_in_B, Data_in_C, Data_out_Sum, Data_out_Carry);  

    // Applying Stimulus here
    initial begin  
        $vcdpluson;   

        // Applying all possible input combinations  
        Data_in_A = 0; Data_in_B = 0; Data_in_C = 0; #10;  
        Data_in_A = 0; Data_in_B = 0; Data_in_C = 1; #10;  
        Data_in_A = 0; Data_in_B = 1; Data_in_C = 0; #10;  
        Data_in_A = 0; Data_in_B = 1; Data_in_C = 1; #10;  
        Data_in_A = 1; Data_in_B = 0; Data_in_C = 0; #10;  
        Data_in_A = 1; Data_in_B = 0; Data_in_C = 1; #10;  
        Data_in_A = 1; Data_in_B = 1; Data_in_C = 0; #10;  
        Data_in_A = 1; Data_in_B = 1; Data_in_C = 1; #10;  

        $finish;  
    end  

endmodule  
