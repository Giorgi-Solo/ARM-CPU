`timescale 1ns / 1ps
///
//////////////////////////////////////////////////////////////////////////////////
module instr_memory(
	input [7:0] instr_ddr_in,
	output [31:0] instruction_out
    );

reg [31:0] instr_memory [0:14];

assign instruction_out = instr_memory[instr_ddr_in];

initial begin
	$readmemb("instructions.txt",instr_memory);
end

endmodule
