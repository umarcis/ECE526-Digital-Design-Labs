/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #9            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment#9 	Parameterized Synchronous FIFO			 ***
***									 ***  
*** Filename: FIFO.sv 		Created by Muhammad Umar, 05/01/2025	 ***  
*** 									 ***  
*** This SystemVerilog testbench verifies the functionality of the 	 ***
*** parameterized FIFO module by testing overflow, underflow, flag 	 ***
*** transitions, simultaneous operations, and First Word Fall Through 	 ***
*** (FWFT) behavior conditionally using ifdef FWFT. 			 ***
***************************************************************************/

module FIFO_tb ();

    parameter DATA_WIDTH          = 8 ;
    parameter DEPTH               = 32;
    parameter ALMOST_FULL_THRESH  = 2 ;
    parameter ALMOST_EMPTY_THRESH = 2 ;

    logic                   clk         ;
    logic                   rst_n       ;
    logic                   wr_en       ;
    logic                   rd_en       ;
    logic [ DATA_WIDTH-1:0] data_in     ;
    logic [ DATA_WIDTH-1:0] data_out    ;
    logic                   empty       ;
    logic                   almost_empty;
    logic                   full        ;
    logic                   almost_full ;
    logic                   overflow    ;
    logic                   underflow   ;
    logic                   valid       ;
    logic [$clog2(DEPTH):0] count       ;

    FIFO #(
        .DATA_WIDTH         (DATA_WIDTH         ),
        .DEPTH              (DEPTH              ),
        .ALMOST_FULL_THRESH (ALMOST_FULL_THRESH ),
        .ALMOST_EMPTY_THRESH(ALMOST_EMPTY_THRESH)
    ) dut (
        .clk         (clk         ),
        .rst_n       (rst_n       ),
        .wr_en       (wr_en       ),
        .rd_en       (rd_en       ),
        .data_in     (data_in     ),
        .data_out    (data_out    ),
        .empty       (empty       ),
        .almost_empty(almost_empty),
        .full        (full        ),
        .almost_full (almost_full ),
        .overflow    (overflow    ),
        .underflow   (underflow   ),
        .valid       (valid       ),
        .count       (count       )
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $vcdpluson;

        clk = 0;
        rst_n = 0;
        wr_en = 0;
        rd_en = 0;
        data_in = 0;

        #10;
        rst_n = 1;


        $display("\n===========================================================================");
        $display("Write to FIFO more than its capacity to test full and overflow");
        $display("===========================================================================\n");

        for (int i = 0; i < (DEPTH + 5); i++) begin
            @(posedge clk);
            wr_en = 1;
            rd_en = 0;
            data_in = i;
            @(posedge clk);
            wr_en = 0;

            $display("Write: %0d, Count: %0d, Full: %b, Almost_Full: %b, Overflow: %b", i, count, full, almost_full, overflow);

            if (full) begin
                $display("*** FIFO is FULL! No more data can be written! ***");
            end else if (almost_full) begin
                $display("\n*** Warning: FIFO is ALMOST FULL! ***\n");
            end
        end

        wr_en = 0;

        $display("\n===========================================================================");
        $display("Read from FIFO until empty to test empty and underflow");
        $display("===========================================================================\n");

        for (int i = 0; i < (DEPTH + 5); i++) begin
            @(posedge clk);
            wr_en = 0;
            rd_en = 1;
            @(posedge clk);
            rd_en = 0;

            $display("Read: %0d, Data_out: %0d, Valid: %b, Count: %0d, Empty: %b, Almost_Empty: %b, Underflow: %b", i, data_out, valid, count, empty, almost_empty, underflow);

            if (underflow) begin
                $display("*** ERROR: FIFO UNDERFLOW occurred! Tried to read when empty! ***");
            end else if (empty) begin
                $display("\n*** FIFO is EMPTY! No more data to read. ***\n");
            end else if (almost_empty) begin
                $display("\n*** Warning: FIFO is ALMOST EMPTY! ***\n");
            end
        end
        rd_en = 0;

        $display("\n===========================================================================");
        $display("Simultaneous write and read");
        $display("===========================================================================\n");
        @(posedge clk);
        wr_en = 1;
        rd_en = 1;
        data_in = 42;
        @(posedge clk);
        wr_en = 0;
        rd_en = 0;
        $display("Simultaneous Write and Read - Data_in: %0d, Data_out: %0d", data_in, data_out);

        @(posedge clk);
        $display("\nFinal Flags Empty: %b, Almost_Empty: %b, Full: %b, Almost_Full: %b, Count: %0d", empty, almost_empty, full, almost_full, count);

        $display("\n===========================================================================");
        $display("Partial Write (few locations) and Readback");
        $display("===========================================================================\n");

        for (int j = 0; j < 3; j++) begin
            @(posedge clk);
            wr_en = 1;
            rd_en = 0;
            data_in = 100 + j;
            @(posedge clk);
            wr_en = 0;
            $display("Partial Write: %0d, Data_in: %0d, Count: %0d, Full: %b", j, data_in, count, full);
        end

        for (int j = 0; j < 4; j++) begin
            @(posedge clk);
            wr_en = 0;
            rd_en = 1;
            @(posedge clk);
            rd_en = 0;
            $display("Partial Read: %0d, Data_out: %0d, Valid: %b, Count: %0d, Empty: %b", j, data_out, valid, count, empty);
        end



        `ifdef FWFT
            @(posedge clk);
            rst_n = 0;
            repeat(2) begin
                @(posedge clk);
            end

            rst_n = 1;

            $display("\n===========================================================================");
            $display("FWFT Behavior Check: Write without Read");
            $display("===========================================================================\n");

            @(posedge clk);
            data_in = 55;
            wr_en = 1;
            rd_en = 0;
            @(posedge clk);
            wr_en = 0;
            repeat(2) begin
                @(posedge clk);
            end

            $display("FWFT Preload Test | Data Written: %0d, Data_out (before rd_en): %0d", data_in, data_out);

            // Now asserting rd_en to consume
            @(posedge clk);
            rd_en = 1;
            @(posedge clk);
            rd_en = 0;

            $display("FWFT Preload Test | After Read, Data_out: %0d, Valid: %b", data_out, valid);
        `endif



        $display("\n===========================================================================");
        $display("Test Finished, All Cases for FIFO are Covered");
        $display("===========================================================================\n");


        $finish;
    end

endmodule