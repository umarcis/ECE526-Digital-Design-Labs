/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #7            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #7 Design and Verification of RAM and ROM using registers ***
***									 ***  
*** Filename: register_file_ram .sv Created by Muhammad Umar, 04/09/2025 ***  
*** 									 ***  
*** This module implements a register file using RAM with separate       ***
*** control for chip select (cs), output enable (oe), and write strobe   ***
*** (ws). It supports bidirectional data transfer through an inout bus,  ***
*** allowing read and write operations based on control signals.         ***
*** The memory depth and data width are parameterizable.                 ***
***************************************************************************/

`timescale 1ns / 1ps

module register_file_ram #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 5,
    parameter DEPTH = 1 << ADDR_WIDTH
)(
    inout [DATA_WIDTH-1:0] data,
    input [ADDR_WIDTH-1:0] addr,
    input cs,      // active low
    input oe,      // active high
    input ws       // write strobe (write on posedge)
);

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    reg [DATA_WIDTH-1:0] read_data;

    // Write Operation (triggered on write strobe)
    always @(posedge ws) begin
        if (!cs && !oe) begin
            mem[addr] <= data;
        end
    end

    // Combinational Read Logic
    always @(*) begin
        if (!cs && oe)
            read_data = mem[addr];
        else
            read_data = {DATA_WIDTH{1'bz}};
    end

    // Drive data bus only during read
    assign data = (!cs && oe) ? read_data : {DATA_WIDTH{1'bz}};

endmodule
