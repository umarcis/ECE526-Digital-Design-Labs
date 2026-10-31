/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #7            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #7 Design and Verification of RAM and ROM using registers ***
***									 ***  
*** Filename:tb_register_file_rom.v Created by Muhammad Umar, 04/09/2025 ***  
*** 									 ***  
*** This testbench verifies the register_file_rom module by reading      ***
*** initialized memory contents and observing outputs based on address.  ***
*** It tests both defined and undefined locations, simulates bit         ***
*** scrambling into a mirror model, and confirms data read behavior      ***
*** under active chip select and output enable signals.                  ***
***************************************************************************/

`timescale 1ns / 1ps

module tb_register_file_rom;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 5;
    parameter DEPTH = 1 << ADDR_WIDTH;

    reg [ADDR_WIDTH-1:0] addr;
    reg cs;
    reg oe;
    wire [DATA_WIDTH-1:0] data;

    // Instantiate ROM
    register_file_rom #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .data(data),
        .addr(addr),
        .cs(cs),
        .oe(oe)
    );

    // Internal RAM model to simulate writing scrambled data
    reg [DATA_WIDTH-1:0] mirror_mem [0:DEPTH-1];
	integer i;

    function [7:0] scramble_bits;
        input [7:0] in_byte;
        begin
            scramble_bits = {in_byte[0], in_byte[7], in_byte[1], in_byte[6], in_byte[2], in_byte[5], in_byte[3], in_byte[4]};
        end
    endfunction

    initial begin
        $vcdpluson;
        $display("================================================");
        $display(" Starting ROM Testbench for register_file_rom");
        $display("================================================");

        cs = 0;
        oe = 1;
        addr = 0;

        #10;

        // Demonstrating initialized data
	$display("\n================================================");
        $display(" Initialized Memory for Checking (0x04 to 0x0F)");
        $display("================================================");

        for (i = 4; i <= 15; i=i+1) begin
            addr = i;
            #5;
            $display("Address %02h = %02h", i, data);
        end

        // Demonstrate undefined locations 
	$display("\n================================================");
        $display(" Unspecified Addresses Checking (should be X)");
        $display("================================================");
        for (i = 0; i < 4; i=i+1) begin
            addr = i;
            #5;
            $display("Address %02h = %02h", i, data);
        end

        // Scramble and simulate write to mirror model 
	$display("\n================================================");
        $display(" Scramble and Rewrite (0x10 to 0x17)");
        $display("================================================");
        for (i = 16; i <= 23; i=i+1) begin
            addr = i;
            #5;
            mirror_mem[i] = scramble_bits(data);
            $display("Original %02h Scrambled = %02h", data, mirror_mem[i]);
        end

        //  Show scrambled memory content 
	$display("\n================================================");
        $display(" Scrambled Values");
        $display("================================================");
        for (i = 16; i <= 23; i = i+1) begin
            $display("Address %02h = %02h", i, mirror_mem[i]);
        end

        // Final memory 
	$display("\n================================================");
        $display(" Full Memory ");
        $display("================================================");
        for (i = 0; i < DEPTH; i=i+1) begin
            addr = i;
            #2;
            $display("ROM[%02h] = %02h", i, data);
        end

        $display("Completed Test Cases for ROM");
        $finish;
    end

endmodule
