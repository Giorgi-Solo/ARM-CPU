`timescale 1ns / 1ps

module tb_PC;

	// Inputs
	reg mux_sel;
	reg clk_in;
	reg [7:0] addr_to_jmp_in;

	// Outputs
	wire [7:0] PC_out;
	wire [7:0] R15_out;

	// Instantiate the Unit Under Test (UUT)
	program_counter uut (
		.mux_sel(mux_sel), 
		.clk_in(clk_in), 
		.addr_to_jmp_in(addr_to_jmp_in), 
		.PC_out(PC_out), 
		.R15_out(R15_out)
	);

	always #5 clk_in=~clk_in;

	initial begin
		// Initialize Inputs
		mux_sel = 0;
		clk_in = 0;
		addr_to_jmp_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
		addr_to_jmp_in=100;
        mux_sel = 1;#10;mux_sel=0;
		// Add stimulus here
		#50;
		addr_to_jmp_in=10;
        mux_sel = 1;#10;mux_sel=0;
		// Add stimulus here

	end
      
endmodule

