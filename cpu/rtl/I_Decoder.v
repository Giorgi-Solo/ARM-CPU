`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
This module determines what kind of instuction is fetched:

	if Type_of_Instruction = 1, we have data-processing instruction
	if Type_of_Instruction = 2, we have memory instruction
	if Type_of_Instruction = 3, we have branching instruction
	if Type_of_Instruction = 0, we have unidentified instruction

This module also determines what kind of data-processing instruction we have:

	if Type_of_Data_Processing = 1, we have immediate
	if Type_of_Data_Processing = 2, we have register shifted by immediate/value
	if Type_of_Data_Processing = 3, we have register shifted by register
	if Type_of_Data_Processing = 4, we have multiplication
	if Type_of_Data_Processing = 0, we have unidentified
	
This module also determines what kind of mem-instruction we have

	if mem_instr_type = 1, Memory instruction type is of Immediate
	if mem_instr_type = 2, Memory instruction type is of "Register shifted by Value"
	if mem_instr_type = 0, Memory instruction type is unidentified
	
This module also determines what kind of jmp-instruction we have

	if jmp_instr_type = 1, Jump instruction type is of Branch only
	if jmp_instr_type = 2, Jump instruction type is of Branch and Link
	if jmp_instr_type = 0, Jump instruction type is unidentified
*/
//////////////////////////////////////////////////////////////////////////////////
module I_Decoder(
    input [31:0] instruction, // 32 bit instruction
    input [3:0] NZCO_Flags_in, // flags
	 output [1:0] OP_out, // output which type of instruction
	 output [3:0] CMD_out, // command
	 output flag_reg_write_en, // enables to update the flag reg
	 output reg mux_sel_branch_out=0, // multiplexer before PC, 0 means next instruction, 1 means branch
	 output reg [23:0] branch_imm_out = 0, // immediate for branch instruction
	 output reg register_file_mux_sel = 1, // by default ALU output is multiplexed to be written in register file
	 output reg register_file_write_en = 0, // enables writing in registers
	 output reg [3:0] base_addr_mem_instr = 0, // base addres/source register
	 output reg [11:0] mem_instr_imm_out = 0, // immediate for memory and data-processing
	 output reg register_file_input_mux = 1, // chooses between 15 and offset register
    output reg [3:0] dest_reg = 0, // destination register for memory instructions
	 output reg memory_write_en = 0, // memory write enable
	 output reg branch_sel = 0 // selects between branch immediate and other immediate
	 );

reg [1:0] Type_of_Instruction; // type of instruciton - not used, gives us potential to make CPU more advanced
reg [2:0] Type_of_Data_Processing; // type of data-processing - not used, gives us potential to make CPU more advanced
reg [1:0] mem_instr_type; // type of memory - not used, gives us potential to make CPU more advanced
reg [1:0] jmp_instr_type; // type of branch - not used, gives us potential to make CPU more advanced

reg conditions_met=1; // checks if conditions for execution are met
wire N,Z,C,O; // flags

assign N = NZCO_Flags_in[3]; // NEGATIVE FLAG
assign Z = NZCO_Flags_in[2]; // ZERO FLAG
assign C = NZCO_Flags_in[1]; // CARRY FLAG
assign O = NZCO_Flags_in[0]; // OVERFLOW FLAG

assign OP_out = (conditions_met==1) ? instruction[27:26] : 3; // output OP - determining type of instruction, OUTPUTs 3 WHENEVER CONDITION IS NOT MET
assign CMD_out = instruction[24:21]; // output CMD
assign flag_reg_write_en = (OP_out==0) & instruction[20]; // update flags if we have dataprocessing inst and S bit of instr is 1
	 
always @(*) begin // determine type of instruction
Type_of_Instruction = instruction[27:26] + 1;
end

always @(*) begin 
if(instruction[27:26]==0) begin // determine type of data-processing
	mem_instr_type = 0;
	jmp_instr_type = 0;
	if(instruction[25]) begin // i is 1
		Type_of_Data_Processing = 1;    // we have immediate
	end
	else if((instruction[24]==0)&&(instruction[7:4]==9)) begin
		Type_of_Data_Processing = 4;	// multiplication
	end
	else if((instruction[7]==0)&(instruction[4]==1)) begin
		Type_of_Data_Processing = 3;	// register shift by register
	end
	else if(instruction[4]==0) begin
		Type_of_Data_Processing = 2;	// register shifted by value
	end
	else Type_of_Data_Processing=0;
end
else if(instruction[27:26]==1) begin // determine type of memory instruction
	Type_of_Data_Processing = 0;
	jmp_instr_type = 0;
	if(instruction[25]==0) begin // ~i is 0
		mem_instr_type = 1; // offset in imediate
	end
	else if(instruction[4]==1) begin // ~i and inst[4] ==1
		mem_instr_type = 2; // offset in shifted register
	end
	else begin
		mem_instr_type = 0; // unidentified
	end
end
else if(instruction[27:25]==3'b101) begin // determine type of jump instruction
	Type_of_Data_Processing = 0;
	mem_instr_type = 0;
	if(instruction[24]==0) begin // L is 0
		jmp_instr_type = 1; // just branch
	end
	else if(instruction[24]==1) begin // L is 1
		jmp_instr_type = 2; // branch and link
	end
	else begin
		jmp_instr_type = 0;
	end
end
else begin // unidentified
	Type_of_Data_Processing = 0;
	jmp_instr_type = 0;
	mem_instr_type = 0;
end
end

always @(*) begin // check if the conditions are met. Not used by our CPU - gives us potential to make CPU more advanced
case(instruction[31:28])
4'b1110: begin // unconditional
				conditions_met=1;
			end
4'b0000: begin // Mnemonic - EQ
				conditions_met = Z;
			end
4'b0001: begin // Mnemonic - NE
				conditions_met = ~Z;
			end
4'b0010: begin // Mnemonic - CS/HS Carry set / unsigned higher or same
				conditions_met = C;
			end
4'b0011: begin // Mnemonic - CC/LO Carry clear / unsigned lower
				conditions_met = ~C;
			end
4'b0100: begin // Mnemonic - MI Minus / negative
				conditions_met = N;
			end
4'b0101: begin // Mnemonic - PL PLUS / POSITIVE
				conditions_met = ~N;
			end
4'b0110: begin // Mnemonic - VS Overflow / overflow set
				conditions_met = O;
			end
4'b0111: begin // Mnemonic - VC No overflow / overflow clear
				conditions_met = ~O;
			end
4'b1000: begin // Mnemonic - HI Unsigned higher
				conditions_met = ~Z&C;
			end
4'b1001: begin // Mnemonic - LS Unsigned lower or same
				conditions_met = Z|(~C);
			end
4'b1010: begin // Mnemonic - GE Signed greater than or equal
				conditions_met = ~(N^O);
			end
4'b1011: begin // Mnemonic - LT Signed less than
				conditions_met = N^O;
			end
4'b1100: begin // Mnemonic - GT Signed greater than
				conditions_met = ~(N^O)&(~Z);
			end
4'b1101: begin // Mnemonic - LE Signed less than or equal
				conditions_met = (N^O)|Z;
			end
default: conditions_met = 0;
endcase
end

always @(*) begin
case(Type_of_Instruction) // generate signals for functions. Type_of_instruction = OP + 1
1: begin		// if Type_of_Instruction = 1, we have data-processing instruction
		mem_instr_imm_out = instruction[11:0]; // immediate out, The name is mem_instr but it is the same for data-process
		dest_reg = instruction[15:12]; // dest register
		register_file_input_mux = 1; // dest reg is multiplexed, not 15
		register_file_mux_sel = 1; // ALU output is multiplexed, not output from data memory
		base_addr_mem_instr = instruction[19:16]; // source register
		
		mux_sel_branch_out = 0; // this 3 lines prevent latches
		branch_imm_out = 0;
		memory_write_en = 0;
		branch_sel = 0;
		if((OP_out==3)|(CMD_out==4'b1010)) //  cmp or  unidentified command
			register_file_write_en = 0; // do not need to write anything into register files
		else
			register_file_write_en = 1; // enable writing in register files
	end
2: begin	// if Type_of_Instruction = 2, we have memory instruction
		base_addr_mem_instr = instruction[19:16]; // base address register number
		mem_instr_imm_out = instruction[11:0]; // immediate out
		dest_reg = instruction[15:12];
		
		mux_sel_branch_out = 0; // next instruction is multiplexed at PC
		branch_imm_out = 0; // prevents latch
		register_file_input_mux = 1; // dest reg is multiplexed not 15
		branch_sel = 0;
		if((instruction[20]==1)&(conditions_met == 1)) begin		// L = 1 -> LDR
			register_file_mux_sel = 0; // Memory output is multiplexed
			register_file_write_en = 1; // enable writing into register file
			memory_write_en = 0; // no need to write into memory
		end
		else begin // L = 0 -> STR
			memory_write_en = 1; // memory write enable
			register_file_mux_sel = 1; // ALU output is multiplexed
			register_file_write_en = 0; // disable writing into register file
		end
	end
3:	begin		// if Type_of_Instruction = 3, we have branching instruction
		memory_write_en = 0;
		mux_sel_branch_out = conditions_met; // send 1 to PC multiplexer
		branch_imm_out = instruction[23:0]; // branch immediate
		register_file_mux_sel = 1;
		register_file_input_mux = 0; // select 15th register.
		register_file_write_en = 0; // disable writing into register file
		base_addr_mem_instr = 15;
		mem_instr_imm_out = 0;
		dest_reg = 15;
		branch_sel = 1;
	end
default: begin 	// if Type_of_Instruction = 0, we have unidentified instruction
				mux_sel_branch_out = 0;
				branch_imm_out = 0;
				register_file_mux_sel = 1;
				register_file_write_en = 0; // disable writing into register file
				base_addr_mem_instr = 0;
				mem_instr_imm_out = 0;
				register_file_input_mux = 1;
				dest_reg = 0;
				branch_sel = 0;
				memory_write_en = 0;
			end
endcase
end

endmodule
