module interleaver_bus (data_in, clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out, data_ready,
                        done);

	input [7:0] data_in;
	input clk, reset;
	input CRC_start, CRC_blocksize, CRC_end; // control signals
	
	output [7:0] data_out;
	output data_ready, done;
	
	wire data_ready0, data_ready1, data_ready2, data_ready3, data_ready4, data_ready5, data_ready6, data_ready7;
	wire done0, done1, done2, done3, done4, done5, done6, done7;
	
	
	interleaver interleaver0 (data_in[0], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[0], data_ready0, done0, 3'd0);
	interleaver interleaver1 (data_in[1], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[1], data_ready1, done1, 3'd1);
	interleaver interleaver2 (data_in[2], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[2], data_ready2, done2, 3'd2);
	interleaver interleaver3 (data_in[3], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[3], data_ready3, done3, 3'd3);
	interleaver interleaver4 (data_in[4], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[4], data_ready4, done4, 3'd4);
	interleaver interleaver5 (data_in[5], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[5], data_ready5, done5, 3'd5);
	interleaver interleaver6 (data_in[6], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[6], data_ready6, done6, 3'd6);
	interleaver interleaver7 (data_in[7], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[7], data_ready7, done7, 3'd7);
	
	and (data_ready, data_ready0, data_ready1, data_ready2, data_ready3, data_ready4, data_ready5, data_ready6, data_ready7);
	and (done, done0, done1, done2, done3, done4, done5, done6, done7);
endmodule