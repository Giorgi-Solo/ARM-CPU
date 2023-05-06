`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:32:02 12/17/2020
// Design Name:   ALU
// Module Name:   C:/Users/SOLO/Desktop/san diego/The Fourht Year/The Fall Semester/COMPE - 475/cpu/cpu/tb_ALU.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_ALU;

	// Inputs
	reg [31:0] portA_in;
	reg [31:0] portB_in;
	reg [1:0] OP;
	reg [3:0] CMD;

	// Outputs
	wire [3:0] flags_out;
	wire [31:0] Result;

	

	initial begin
		// Initialize Inputs
		portA_in = 0;
		portB_in = 0;
		OP = 0;
		CMD = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

