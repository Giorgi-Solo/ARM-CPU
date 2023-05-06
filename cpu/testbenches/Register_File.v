
//////////////////////////////////////////////////////////////////////////////////
module Register_File(
    input [3:0] add_portA_in,//19:16
    input [3:0] add_portB_in,//15:12
    input [31:0] pc_R15,
    input [31:0] data_in,
    input write_en_in,
    input clk_in,
    output [31:0] data_portA_out,
    output [31:0] data_portB_out
    );

reg [31:0] register_file [0:15];

initial begin
	$readmemb("register_file.txt",register_file);
end

assign data_portA_out = register_file[add_portA_in];
assign data_portB_out = register_file[add_portB_in];

always @(posedge clk_in) begin
	register_file[15] = pc_R15; //
	if(write_en_in==1)
		register_file[add_portB_in] = data_in; // portb instr[15:12]
end
endmodule
