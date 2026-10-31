/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #4            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #4 Design 8bit register with instances of Mux and DFF     ***  
***									 ***  
*** Filename: register8bit.v   	    Created by Muhammad Umar, 03/07/2025 ***  
*** 									 ***  
*** This module implements a logic circuit of register with instances    ***  
*** of Mux and D Flipflops.  						 ***  
***************************************************************************/ 


`timescale 1 ns / 100 ps

module register8bit(
    input clk, 
    input rst_n,  // active low reset
    input ena,  
    input [7:0] data,
    output [7:0] r
);
    wire [7:0] mux_out;

    // Instantiating Mux and dff module and making multiple instances  and correct port mapping
    MUX2_1 dut_mux0 (.OUT(mux_out[0]), .A(r[0]), .B(data[0]), .SEL(ena));
    dff dut_dff0 (.clk(clk), .rst_n(rst_n), .d(mux_out[0]), .q(r[0]));

    MUX2_1 dut_mux1 (.OUT(mux_out[1]), .A(r[1]), .B(data[1]), .SEL(ena));
    dff dut_dff1 (.clk(clk), .rst_n(rst_n), .d(mux_out[1]), .q(r[1]));

    MUX2_1 dut_mux2 (.OUT(mux_out[2]), .A(r[2]), .B(data[2]), .SEL(ena));
    dff dut_dff2 (.clk(clk), .rst_n(rst_n), .d(mux_out[2]), .q(r[2]));

    MUX2_1 dut_mux3 (.OUT(mux_out[3]), .A(r[3]), .B(data[3]), .SEL(ena));
    dff dut_dff3 (.clk(clk), .rst_n(rst_n), .d(mux_out[3]), .q(r[3]));

    MUX2_1 dut_mux4 (.OUT(mux_out[4]), .A(r[4]), .B(data[4]), .SEL(ena));
    dff dut_dff4 (.clk(clk), .rst_n(rst_n), .d(mux_out[4]), .q(r[4]));

    MUX2_1 dut_mux5 (.OUT(mux_out[5]), .A(r[5]), .B(data[5]), .SEL(ena));
    dff dut_dff5 (.clk(clk), .rst_n(rst_n), .d(mux_out[5]), .q(r[5]));

    MUX2_1 dut_mux6 (.OUT(mux_out[6]), .A(r[6]), .B(data[6]), .SEL(ena));
    dff dut_dff6 (.clk(clk), .rst_n(rst_n), .d(mux_out[6]), .q(r[6]));

    MUX2_1 dut_mux7 (.OUT(mux_out[7]), .A(r[7]), .B(data[7]), .SEL(ena));
    dff dut_dff7 (.clk(clk), .rst_n(rst_n), .d(mux_out[7]), .q(r[7]));

endmodule
