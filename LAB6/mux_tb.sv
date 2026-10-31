/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #6            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #6 Design and Verification of Parametrized MUX    	 ***
***									 ***  
*** Filename: mux_tb.sv  	Created by Muhammad Umar, 04/04/2025     ***  
*** 									 ***  
*** This testbench module verify the Parametrized Mux design according   ***  
*** to the cases defined in lab instruction			         ***
***************************************************************************/


module mux_tb;

  // Taking 6bit reg to cover all the cases
  logic [5:0] A, B;
  logic       sel;

  // Outputs from each mux instances according to their respective names
  logic out1;
  logic [3:0] out4;
  logic [4:0] out5;
  logic [5:0] out6;

  // Instance 1: default parameter 1-bit width
  mux m1 (
    .A(A[0]),
    .B(B[0]),
    .sel(sel),
    .out(out1)
  );

  // Instance 2: override via defparam
  mux m2 (
    .A(A[3:0]),
    .B(B[3:0]),
    .sel(sel),
    .out(out4)
  );
  defparam m2.SIZE = 4;

  // Instance 3: override via module parameter list
  mux #(.SIZE(5)) m3 (
    .A(A[4:0]),
    .B(B[4:0]),
    .sel(sel),
    .out(out5)
  );

  // Instance 4: override via localparam 
  localparam SIZE = 6;
  mux #(SIZE) m4 (
    .A(A),
    .B(B),
    .sel(sel),
    .out(out6)
  );

// Test sequence
  initial begin
    $vcdpluson;

    $display("\n*********************************************************************************************");
    $display("Starting Parameterized MUX Testbench");
    $display("*********************************************************************************************\n");

    // CASE 1: sel = 0 → output = A
    $display("*********************************************************************************************");
    $display("CASE 1: sel = 0 → output should be A");
    $display("\n");

    sel = 1'b0;
    A   = 6'b101010;
    B   = 6'b010101;
    #5;
    $display("sel=0 | A=%b B=%b | out1=%b out4=%b out5=%b out6=%b", A, B, out1, out4, out5, out6);

    // CASE 2: sel = 1 → output = B
    $display("\n*********************************************************************************************");
    $display("CASE 2: sel = 1 → output should be B");
    $display("\n");

    sel = 1'b1;
    A   = 6'b111100;
    B   = 6'b000011;
    #5;
    $display("sel=1 | A=%b B=%b | out1=%b out4=%b out5=%b out6=%b", A, B, out1, out4, out5, out6);

    // CASE 3: sel = x, A == B → output = A (no x expected)
    $display("\n*********************************************************************************************");
    $display("CASE 3: sel = x, A == B → output = A (no x)");
    $display("\n");

    sel = 1'bx;
    A   = 6'b110011;
    B   = 6'b110011;
    #5;
    $display("sel=x, A==B | A=%b B=%b | out1=%b out4=%b out5=%b out6=%b", A, B, out1, out4, out5, out6);

    // CASE 4: sel = x, A != B → output = x (all bits conflict)
    $display("\n*********************************************************************************************");
    $display("CASE 4: sel = x, A != B → output = x (conflicts)");
    $display("\n");

    sel = 1'bx;
    A   = 6'b111000;
    B   = 6'b000111;
    #5;
    $display("sel=x, A!=B | A=%b B=%b | out1=%b out4=%b out5=%b out6=%b", A, B, out1, out4, out5, out6);

    // CASE 5: sel = x, A and B share some bits (mixed match)
    $display("\n*********************************************************************************************");
    $display("CASE 5: sel = x, A and B share some bits");
    $display("\n");

    sel = 1'bx;
    A   = 6'b101011;
    B   = 6'b101101;
    #5;
    $display("sel=x, mixed A/B | A=%b B=%b | out1=%b out4=%b out5=%b out6=%b", A, B, out1, out4, out5, out6);

    // EXTRA: Confirm all bits go to 0 and 1
    $display("\n*********************************************************************************************");
    $display("CASE 6: Toggle every bit in output to both 0 and 1");
    $display("Making sure no bits are stuck");
    $display("\n");

    // Each bit goes to 0
    sel = 1'b0;
    A   = 6'b000000;
    B   = 6'b111111;
    #5;
    $display("All output bits to 0: A=%b B=%b | out1=%b out4=%b out5=%b out6=%b", A, B, out1, out4, out5, out6);

    // Each bit goes to 1
    sel = 1'b0;
    A   = 6'b111111;
    B   = 6'b000000;
    #5;
    $display("All output bits to 1: A=%b B=%b | out1=%b out4=%b out5=%b out6=%b", A, B, out1, out4, out5, out6);

    $display("\n*********************************************************************************************");
    $display("Mux Testbench Finished.");
    $display("*********************************************************************************************\n");

    $finish;
  end

endmodule

