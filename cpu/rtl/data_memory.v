`timescale 1ns / 1ps
///
//////////////////////////////////////////////////////////////////////////////////
module data_memory(
	input clk_in,
	input write_en_in,
	input [7:0] addr_in,
	input [31:0] data_in,
	output [31:0] data_out
    );

reg [31:0] data_memory [0:10];

assign data_out = data_memory[addr_in];

always @(posedge clk_in) begin
	if(write_en_in==1)
		data_memory[addr_in] <= data_in;

end

initial begin
	$readmemb("data_memory.txt",data_memory);
end

endmodule
