/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #9            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment#9 	Parameterized Synchronous FIFO 			 ***
***									 ***  
*** Filename: FIFO.sv 		Created by Muhammad Umar, 05/01/2025	 ***  
*** 									 ***  
*** This FIFO module implements a parameterized synchronous FIFO	 ***
*** with support for optional First Word Fall Through (FWFT) using ifdef,***
*** along with standard status flags and overflow/underflow detection.   ***
***************************************************************************/


`timescale 1ns / 1ps


module FIFO #(
    parameter DATA_WIDTH          = 8 ,
    parameter DEPTH               = 32,
    parameter ALMOST_FULL_THRESH  = 2 ,
    parameter ALMOST_EMPTY_THRESH = 2
) (
    input  logic                   clk         ,
    input  logic                   rst_n       ,
    input  logic                   wr_en       ,
    input  logic                   rd_en       ,
    input  logic [ DATA_WIDTH-1:0] data_in     ,
    output logic [ DATA_WIDTH-1:0] data_out    ,
    output logic                   empty       ,
    output logic                   almost_empty,
    output logic                   full        ,
    output logic                   almost_full ,
    output logic                   overflow    ,
    output logic                   underflow   ,
    output logic                   valid       ,
    output logic [$clog2(DEPTH):0] count
);

    logic [   DATA_WIDTH-1:0] mem   [0:DEPTH-1];
    logic [$clog2(DEPTH)-1:0] rd_ptr, wr_ptr;

    `ifdef FWFT
        logic preload;
    `endif

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            rd_ptr       <= 0;
            wr_ptr       <= 0;
            count        <= 0;
            empty        <= 1;
            full         <= 0;
            almost_empty <= 1;
            almost_full  <= 0;
            overflow     <= 0;
            underflow    <= 0;
            valid        <= 0;
            data_out     <= 0;
            `ifdef FWFT
                preload <= 0;
            `endif
        end else begin
            // Write operation
            if (wr_en && !full) begin
                mem[wr_ptr] <= data_in;
                wr_ptr      <= (wr_ptr + 1) % DEPTH;
                count       <= count + 1;
                overflow    <= 0;
            end else if (wr_en && full) begin
                overflow <= 1;
            end else begin
                overflow <= 0;
            end


            `ifdef FWFT
                if (!rd_en && !empty && !valid) begin
                    data_out <= mem[rd_ptr];
                    preload  <= 1;
                end
            `endif

            // Read operation
            if (rd_en && !empty) begin
                data_out <= mem[rd_ptr];
                rd_ptr   <= (rd_ptr + 1) % DEPTH;
                count    <= count - 1;
                valid    <= 1;
                `ifdef FWFT
                    preload <= 0;
                `endif
                underflow <= 0;
            end else if (rd_en && empty) begin
                underflow <= 1;
		valid    <= 0;
            end else begin
                underflow <= 0;
            end

            // Flags
            empty        <= (count == 0);
            almost_empty <= (count <= ALMOST_EMPTY_THRESH);
            full         <= (count == DEPTH);
            almost_full  <= (count >= (DEPTH - ALMOST_FULL_THRESH));
        end
    end



endmodule
