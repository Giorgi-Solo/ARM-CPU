`timescale 1ns / 1ps

module CPU(
    input clk_in,
	 output mash
    );
// Outputs
// I_Decoder
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
	wire branch_sel;

// ALU
	wire [3:0] flags_out;
	wire [31:0] Result;

// Register File
	wire [31:0] data_portA_out;
	wire [31:0] data_portB_out;

// Data memory
	wire [31:0] data_out_data_mem;
	
// instr memory
	wire [31:0] instruction_out;

// PC
	wire [7:0] PC_out;
	wire [7:0] R15_out;

reg [3:0] NZCO_Flags_in = 0;
always @(posedge clk_in) begin // flags register
if(flag_reg_write_en)
	NZCO_Flags_in <= flags_out;
end

wire [31:0] data_in; // Multiplexer between ALU output and data memory output
assign data_in = (register_file_mux_sel==1) ? Result : data_out_data_mem;

// multiplexer between branch immediate and other immediate
wire [31:0] mem_instr_imm_in;
wire [31:0] branch_imm_in;
wire [31:0] portB_in; // AT aLU
assign mem_instr_imm_in = (mem_instr_imm_out[11] == 1)?{20'hFFFFF,mem_instr_imm_out}:{20'b0,mem_instr_imm_out};
assign branch_imm_in = (branch_imm_out[23] == 1)?{8'hFF,branch_imm_out}:{8'b0,branch_imm_out};
assign portB_in = (branch_sel==0)? mem_instr_imm_in: branch_imm_in;

	// Instantiate the Unit Under Test (UUT)
	I_Decoder uut0 (
		.instruction(instruction_out), 
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
		.memory_write_en(memory_write_en),
		.branch_sel(branch_sel)
	);
// Instantiate the Unit Under Test (UUT)
	ALU uut1 (
		.portA_in(data_portA_out), 
		.portB_in(portB_in), 
		.OP(OP_out), 
		.CMD(CMD_out), 
		.flags_out(flags_out), 
		.Result(Result)
	);
// Instantiate the Unit Under Test (UUT)
	Register_File uut2 (
		.add_portA_in(base_addr_mem_instr), 
		.add_portB_in(dest_reg), 
		.pc_R15({24'b0,R15_out}), 
		.data_in(data_in), 
		.write_en_in(register_file_write_en), 
		.clk_in(clk_in), 
		.data_portA_out(data_portA_out), 
		.data_portB_out(data_portB_out)
	);
// Instantiate the Unit Under Test (UUT)
	data_memory uut3 (
		.clk_in(clk_in), 
		.write_en_in(memory_write_en), 
		.addr_in(Result[7:0]), 
		.data_in(data_portB_out), 
		.data_out(data_out_data_mem)
	);
// instr memory
instr_memory uut4 (
		.instr_ddr_in(PC_out), 
		.instruction_out(instruction_out)
	);
// Instantiate the Unit Under Test (UUT)
	program_counter uut5 (
		.mux_sel(mux_sel_branch_out), 
		.clk_in(clk_in), 
		.addr_to_jmp_in(Result[7:0]), 
		.PC_out(PC_out), 
		.R15_out(R15_out)
	);

endmodule
