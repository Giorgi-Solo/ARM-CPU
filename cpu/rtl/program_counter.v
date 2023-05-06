`timescale 1ns / 1ps

module program_counter(
    input mux_sel, // selects next instruction address
    input clk_in,
    input [7:0] addr_to_jmp_in, // specifies address wher to jump
    output reg [7:0] PC_out=0, // output of PC
    output [7:0] R15_out // This will be written in register file 15
    );

wire [7:0] PC_in; 

assign PC_in = (mux_sel==1) ? addr_to_jmp_in:PC_out+1; // mux that selects the next instruction address

assign R15_out = PC_out+2; // PC+2

always @(posedge clk_in) begin // PC
	PC_out <= PC_in; 
end

endmodule
