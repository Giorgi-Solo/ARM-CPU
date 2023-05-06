`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:35:38 12/17/2020
// Design Name:   instr_memory
// Module Name:   C:/Users/SOLO/Desktop/san diego/The Fourht Year/The Fall Semester/COMPE - 475/cpu/cpu/tb_instr_mem.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: instr_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_instr_mem;

	// Inputs
	reg [7:0] instr_ddr_in;

	// Outputs
	wire [31:0] instruction_out;

	// Instantiate the Unit Under Test (UUT)
	instr_memory uut (
		.instr_ddr_in(instr_ddr_in), 
		.instruction_out(instruction_out)
	);

	initial begin
		// Initialize Inputs
		instr_ddr_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

