/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #7            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #7 Design and Verification of RAM and ROM using registers ***
***									 ***  
*** Filename: register_file_rom.v Created by Muhammad Umar, 04/09/2025   ***  
*** 									 ***  
*** This module implements a read-only memory (ROM) block with        	 ***
*** parameterizable data width and depth. Contents are initialized     	 ***
*** from an external .mem file at simulation start. The module supports  ***
*** chip select (cs) and output enable (oe) controls, and outputs data   ***
*** in a high-impedance state when disabled.                             ***
***************************************************************************/

`timescale 1ns / 1ps

module register_file_rom #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 5,
    parameter DEPTH = 1 << ADDR_WIDTH
)(
    output [DATA_WIDTH-1:0] data,
    input [ADDR_WIDTH-1:0] addr,
    input cs,  // active low
    input oe   // active high
);

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Initialize ROM contents from file
    initial begin
        $readmemh("rom_data.mem", mem);
    end

    // Output logic
    assign data = (!cs && oe) ? mem[addr] : {DATA_WIDTH{1'bz}};

endmodule

