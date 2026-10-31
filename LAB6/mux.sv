/***************************************************************************  
***									 ***  
*** EE 526 L Experiment #6            Muhammad Umar, Spring, 2025        ***  
***									 ***  
*** Experiment #6 Design and Verification of Parametrized MUX    	 ***
***									 ***  
*** Filename: mux.sv  		Created by Muhammad Umar, 04/04/2025     ***  
*** 									 ***  
*** This module implements a logic circuit that selects          	 ***  
*** between two SIZE-bit inputs (A and B) using a 1-bit select signal    ***
*** (sel).  It is a purely combinational design that resolves unknown    ***
*** select conditions at the bit level without requiring any clock. 	 ***
***************************************************************************/

module mux #(
  parameter SIZE = 1
)(
  input  logic [SIZE-1:0] A,
  input  logic [SIZE-1:0] B,
  input  logic            sel,
  output logic [SIZE-1:0] out
);

always_comb begin
  for (int i = 0; i < SIZE; i++) begin
    case (sel)
      1'b0: out[i] = A[i];
      1'b1: out[i] = B[i];
      default: begin
        // sel = x or z
        if (A[i] === B[i])
          out[i] = A[i];
        else
          out[i] = 1'bx;
      end
    endcase
  end
end

endmodule