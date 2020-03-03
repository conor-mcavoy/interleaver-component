module interleaver (data_in, clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out, data_ready, done);
	input data_in;
	input clk, reset;
	input CRC_start, CRC_blocksize, CRC_end; // control signals
	
	output data_out;
	output data_ready, done; // control signals
	
	wire [3:0] test1, test2;
	wire p1mode, p2mode; // 0 for reading, 1 for writing
	wire counter1_reset, counter2_reset; // local resets (will still be triggered on global reset)
	wire counter1_enable, counter2_enable;
	wire ram1_we, ram2_we; // RAM write enables
	wire counter1_done, counter2_done; // asserted when counters have reached their targets
	wire p1blocksize, p2blocksize; // 0 for small, 1 for large
	interleaver_fsm FSM (clk, reset, CRC_blocksize, test1, test2, CRC_start, data_in, CRC_end, data_ready,
	                     done, p1mode, p2mode, counter1_reset, counter2_reset, counter1_enable,
								counter2_enable, ram1_we, ram2_we, counter1_done, counter2_done, p1blocksize, p2blocksize);
	

	wire [12:0] count1;
	counter_wrapper1 counter_wrapper1_inst (counter1_enable, p1blocksize, clk, reset, count1, counter1_done);
	
	wire [12:0] pi1_small_value;
	pi1_small pi1_small_inst (count1, clk, pi1_small_value);
	
	wire [12:0] pi1_large_value;
	pi1_large pi1_large_inst (count1, clk, pi1_large_value);
	
	
	wire [12:0] count2;
	counter_wrapper2 counter_wrapper2_inst (counter2_enable, p2blocksize, clk, reset, count2, counter2_done);
	
	wire [12:0] pi2_small_value;
	pi2_small pi2_small_inst (count2, clk, pi2_small_value);
	
	wire [12:0] pi1_large_value;
	pi2_large pi2_large_inst (count2, clk, pi2_large_value);
	
	
	
	
	
	
endmodule