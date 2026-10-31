/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #7            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #7 Design and Verification of RAM and ROM using registers ***
***									 ***  
*** Filename:tb_register_file_ram.v Created by Muhammad Umar, 04/09/2025 ***  
*** 									 ***  
*** This testbench verifies the functionality of the register_file_ram 	 ***
*** module by simulating various read/write operations. It exercises     ***
*** sequential writes, individual and block reads, disabled-state        ***
*** behavior, and bus high-impedance conditions. It also includes        ***
*** pattern tests like walking ones for functional validation.           ***
***************************************************************************/

`timescale 1ns / 1ps

module tb_register_file_ram;

    // Parameters
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 5;
    parameter DEPTH = 1 << ADDR_WIDTH;

    reg [ADDR_WIDTH-1:0] addr;
    reg cs;
    reg oe;
    reg ws;
    wire [DATA_WIDTH-1:0] data;
    reg [DATA_WIDTH-1:0] data_driver;
    reg data_drive_en;
    integer i;

    assign data = data_drive_en ? data_driver : {DATA_WIDTH{1'bz}};

    register_file_ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .data(data),
        .addr(addr),
        .cs(cs),
        .oe(oe),
        .ws(ws)
    );

    initial begin
	$vcdpluson;
        $display("================================================");
        $display(" Starting RAM Testbench for register_file_ram");
        $display("================================================");

        addr = 0;
        cs = 1; oe = 0; ws = 0;
        data_driver = 0;
        data_drive_en = 0;

        #10;

        // A. Write to all memory locations
        $display("\n========================================================");
        $display(" Writing 0 to 31 into addresses 0 to 31 (sequential)");
        $display("==========================================================");
        cs = 0; oe = 0;
        for (i = 0; i < DEPTH; i = i + 1) begin
            addr = i;
            data_driver = i;
            data_drive_en = 1;
            #5; ws = 1; #5; ws = 0; #5;
            $display("  Time %0t | WROTE %0d at Address %0d", $time, data_driver, addr);
        end
        data_drive_en = 0;

        // A, E. Read all back (individual read)
        $display("\n===============================================================");
        $display(" Reading back values (verifying uniqueness for 32 locations)");
        $display("===============================================================");
        oe = 1;
        for (i = 0; i < DEPTH; i = i + 1) begin
            addr = i;
            #10;
            $display("  Time %0t | READ %0d from Address %0d", $time, data, addr);
        end
        oe = 0;

        // B. Block Read (keep oe high)
        $display("\n=============================================");
        $display(" Block Read test (keep oe high)");
        $display("=============================================");
        oe = 1;
        for (i = 0; i < 5; i = i + 1) begin
            addr = i;
            #10;
            $display("  Time %0t | Output Enable(oe)=%b BLOCK READ Address %0d => %h", $time,oe, i, data);
        end
        oe = 0;

        // C. Test Disabled State
        $display("\n=============================================================");
        $display(" Testing disabled states (should ignore oe/ws when cs = 1)");
        $display("=============================================================");
        cs = 1; oe = 1; ws = 1;
        addr = 0;
        data_drive_en = 1;
        data_driver = 8'hAA;  // try writing this
        #10; ws = 0; #10;
        $display("  Time %0t | cs=1 writing = %0h to Address = %0d should be ignored", $time, data_driver, addr);
        data_drive_en = 0;

        // Read back and confirm not written
        $display("\n=============================================");
        $display(" Read back and confirm not written");
        $display("=============================================");
        cs = 0; oe = 1;
        addr = 0;
        #10;
        $display("  Time %0t | Value at Address 0 (should still be 0): Data = %h", $time, data);
        oe = 0;

        // D. High-Z Test
        $display("\n=============================================");
        $display(" High-Z test When Chip Select is Active (cs=1)");
        $display("=============================================");
        addr = 0;
        cs = 1; oe = 1;
        #10;
        if (data === {DATA_WIDTH{1'bz}})
            $display("  Time %0t Chip Select(cs) = %b | PASS: Data bus is high-Z as expected: %b", $time, cs, data);
        else
            $display("  Time %0t Chip Select(cs) = %b | FAIL: Data bus is not high-Z: %b", $time, cs, data);
        cs = 0; oe = 0;


	// E. High-Z when OE goes low (cs = 0)
        $display("\n==============================================================");
        $display(" Checking that data bus becomes High-Z when oe goes low (cs = 0)");
        $display("==============================================================");
        addr = 0;
        cs = 0;
        oe = 1;
        #10; 
        $display("  Time %0t | oe=1 Data driven = %b", $time, data);

        oe = 0; // output will go to high-Z
        #10;

        if (data === {DATA_WIDTH{1'bz}})
            $display("  Time %0t | oe=0 PASS: Data bus returned to High-Z: %b", $time, data);
        else
            $display("  Time %0t | oe=0 FAIL: Data bus is not High-Z: %b", $time, data);

        // F. Walking Ones Pattern (4-bit pattern to 4 addresses)
        $display("\n=============================================");
        $display(" Writing 8-bit Walking Ones pattern");
        $display("=============================================");
        for (i = 0; i < 8; i = i + 1) begin
            addr = i;
            data_driver = 1 << i;
            data_drive_en = 1;
            #5; ws = 1; #5; ws = 0; #5;
            $display("  Time %0t | WROTE %b at Address %0d", $time, data_driver, addr);
        end
        data_drive_en = 0;

        $display("\n=============================================");
        $display(" Reading back Walking Ones pattern");
        $display("=============================================");
        oe = 1;
        for (i = 0; i < 8; i = i + 1) begin
            addr = i;
            #10;
            $display("  Time %0t | READ %b from Address %0d", $time, data, addr);
        end
        oe = 0;

        $display("\n Test Cases Completed.");
        $display("=============================================\n");
        $finish;
    end

endmodule
