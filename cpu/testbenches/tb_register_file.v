`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:33:58 12/17/2020
// Design Name:   Register_File
// Module Name:   C:/Users/SOLO/Desktop/san diego/The Fourht Year/The Fall Semester/COMPE - 475/cpu/cpu/tb_register_file.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Register_File
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_register_file;

	// Inputs
	reg [3:0] add_portA_in;
	reg [3:0] add_portB_in;
	reg [31:0] pc_R15;
	reg [31:0] data_in;
	reg write_en_in;
	reg clk_in;

	// Outputs
	wire [31:0] data_portA_out;
	wire [31:0] data_portB_out;

	// Instantiate the Unit Under Test (UUT)
	Register_File uut (
		.add_portA_in(add_portA_in), 
		.add_portB_in(add_portB_in), 
		.pc_R15(pc_R15), 
		.data_in(data_in), 
		.write_en_in(write_en_in), 
		.clk_in(clk_in), 
		.data_portA_out(data_portA_out), 
		.data_portB_out(data_portB_out)
	);

	initial begin
		// Initialize Inputs
		add_portA_in = 0;
		add_portB_in = 0;
		pc_R15 = 0;
		data_in = 0;
		write_en_in = 0;
		clk_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

