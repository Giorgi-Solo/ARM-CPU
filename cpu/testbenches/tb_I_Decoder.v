`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:32:59 12/17/2020
// Design Name:   I_Decoder
// Module Name:   C:/Users/SOLO/Desktop/san diego/The Fourht Year/The Fall Semester/COMPE - 475/cpu/cpu/tb_I_Decoder.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: I_Decoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_I_Decoder;

	// Inputs
	reg [31:0] instruction;
	reg [3:0] NZCO_Flags_in;

	// Outputs
	wire [1:0] OP_out;
	wire [3:0] CMD_out;
	wire flag_reg_write_en;
	wire mux_sel_branch_out;
	wire [23:0] branch_imm_out;
	wire register_file_mux_sel;
	wire register_file_write_en;
	wire [3:0] base_addr_mem_instr;
	wire [11:0] mem_instr_imm_out;
	wire register_file_input_mux;
	wire [3:0] dest_reg;
	wire memory_write_en;

	// Instantiate the Unit Under Test (UUT)
	I_Decoder uut (
		.instruction(instruction), 
		.NZCO_Flags_in(NZCO_Flags_in), 
		.OP_out(OP_out), 
		.CMD_out(CMD_out), 
		.flag_reg_write_en(flag_reg_write_en), 
		.mux_sel_branch_out(mux_sel_branch_out), 
		.branch_imm_out(branch_imm_out), 
		.register_file_mux_sel(register_file_mux_sel), 
		.register_file_write_en(register_file_write_en), 
		.base_addr_mem_instr(base_addr_mem_instr), 
		.mem_instr_imm_out(mem_instr_imm_out), 
		.register_file_input_mux(register_file_input_mux), 
		.dest_reg(dest_reg), 
		.memory_write_en(memory_write_en)
	);

	initial begin
		// Initialize Inputs
		instruction = 0;
		NZCO_Flags_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

