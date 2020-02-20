module interleaver (data_in, clk, reset, control_bus_in, data_out, control_bus_out, q_pi1);
	input data_in;
	input clk, reset;
	input [3:0] control_bus_in;
	
	output data_out;
	output [3:0] control_bus_out;
	
	wire [12:0] count;
	counter counter1 (1, clk, reset, count);
	
	wire [12:0] address;
	assign address = count;
	
	output [12:0] q_pi1;
	//wire [12:0] q_pi1;
	pi1 pi1_block (reset, address, clk, q_pi1);
endmodule