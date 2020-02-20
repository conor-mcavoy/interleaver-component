module interleaver (data_in, clk, reset, control_bus_in, data_out, control_bus_out, count);
	input data_in;
	input clk, reset;
	input [3:0] control_bus_in;
	
	output data_out;
	output [3:0] control_bus_out;
	output [12:0] count;
	
	//wire [12:0] count;
	counter counter1 (1, clk, reset, count);	
endmodule