`timescale 1ns / 1ps

module ALU(
    input [31:0] portA_in, // port A - Rn
    input [31:0] portB_in, // port b - SRC
    input [1:0] OP,			// OP 
    input [3:0] CMD,			// command
    output reg [3:0] flags_out=0,// flags out - NZCO
    output reg [31:0] Result=0   // result
    );

always @(*) begin
if(OP==0) begin // data-processing
	case(CMD) 
		4'b0000: begin // Bitwise AND 
						Result = portA_in & portB_in;
					end
		4'b0001: begin // Bitwise XOR
						Result = portA_in ^ portB_in;
					end
		4'b0010: begin //  SUB
						Result = portA_in - portB_in;
					end
		4'b0011: begin //  RSB
						Result = portB_in - portA_in;
					end
		4'b0100: begin //  ADD
						Result = portA_in + portB_in;
					end
		4'b1100: begin // Bitwise ORR
						Result = portA_in | portB_in;
					end
		4'b1010: begin //  CMP
						Result = portA_in-portB_in;
					end
		default: begin
						Result=0;
					end
	endcase
end
else if(OP==1) begin // Memory instruction
	case(CMD[2]) // check U
		0: Result = portA_in-portB_in; // base addr - offset
		1: Result = portA_in+portB_in; // base addr + offset
		default: Result = portA_in+portB_in;
	endcase
end
else if(OP==2) begin // Branching
	Result = portA_in+portB_in;
end
else begin//////
Result=0;
end///////////

flags_out[3] =(Result[31]==1); // SET/CLEAR N flag
flags_out[2] = (Result==0); // SET/CLEAR z flag
if((CMD==4'b0010)|(CMD==4'b1010)) begin // sub cmp
	flags_out[1] = Result[31];//portA_in < portB_in; // SET/CLEAR c flag
	flags_out[0] = (portA_in[31]!=portB_in[31])&(portA_in[31]!=Result[31]); // SET/CLEAR o flag
end
else if(CMD==4'b0011) begin // rvsub
	flags_out[1] = portA_in > portB_in; // SET/CLEAR c flag
	flags_out[0] = (portA_in[31]!=portB_in[31])&(portB_in[31]!=Result[31]); // SET/CLEAR o flag
end
else if(CMD==4'b0100) begin // add
	flags_out[1] = (portA_in > Result)|(Result < portB_in); // SET/CLEAR c flag
	flags_out[0] = (portA_in[31]==portB_in[31])&(portA_in[31]!=Result[31]); // SET/CLEAR o flag
end
else begin
	flags_out[1] = 0;
	flags_out[0] = 0;
end
end
endmodule
