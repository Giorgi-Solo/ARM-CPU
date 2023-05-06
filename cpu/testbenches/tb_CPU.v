`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:07:50 12/17/2020
// Design Name:   CPU
// Module Name:   C:/Users/SOLO/Desktop/san diego/The Fourht Year/The Fall Semester/COMPE - 475/cpu/cpu/tb_CPU.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_CPU;

	// Inputs
	reg clk_in;

	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clk_in(clk_in)
	);
	always #1 clk_in = ~clk_in;
	initial begin
		// Initialize Inputs
		clk_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

