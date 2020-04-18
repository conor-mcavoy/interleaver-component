module interleaver_bus (data_in, clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out, data_ready,
                        done,
								data_in_port0,data_in_port1,data_in_port2,data_in_port3,data_in_port4,data_in_port5,data_in_port6,data_in_port7
							
								
								/*,pi2_value_test0,count2_test0
								,pi2_value_test1,count2_test1
								,pi2_value_test2,count2_test2
								,pi2_value_test3,count2_test3
								,pi2_value_test4,count2_test4
								,pi2_value_test5,count2_test5
								,pi2_value_test6,count2_test6
								,pi2_value_test7,count2_test7*/
								,counter1_reset1,counter1_reset2,counter1_reset3,counter1_reset4,counter1_reset5,counter1_reset6,counter1_reset7,counter1_reset0
								/*,pi1_value_test1,pi1_value_test2,pi1_value_test3,pi1_value_test4,pi1_value_test5,pi1_value_test6,pi1_value_test7,pi1_value_test0
								,count1_test0,count1_test1,count1_test2,count1_test3,count1_test4,count1_test5,count1_test6,count1_test7*/
								,done0, done1, done2, done3, done4, done5, done6, done7
								,r1_wetest0,r1_wetest1,r1_wetest2,r1_wetest3,r1_wetest4,r1_wetest5,r1_wetest6,r1_wetest7,
								state0,next_state0,state1,next_state1,state2,next_state2,state3,next_state3,state4,next_state4,state5,next_state5,state6,next_state6,state7,next_state7);

	input [7:0] data_in;
	input clk, reset;
	input CRC_start, CRC_blocksize, CRC_end; // control signals
	output data_in_port0,data_in_port1,data_in_port2,data_in_port3,data_in_port4,data_in_port5,data_in_port6,data_in_port7
								,r1_wetest0,r1_wetest1,r1_wetest2,r1_wetest3,r1_wetest4,r1_wetest5,r1_wetest6,r1_wetest7
								,counter1_reset1,counter1_reset2,counter1_reset3,counter1_reset4,counter1_reset5,counter1_reset6,counter1_reset7,counter1_reset0;
	output [7:0] data_out;
	output data_ready, done;
	/*output [12:0] count1_test0,count1_test1,count1_test2,count1_test3,count1_test4,count1_test5,count1_test6,count1_test7,pi1_value_test1,pi1_value_test2,pi1_value_test3,pi1_value_test4,pi1_value_test5,pi1_value_test6,pi1_value_test7,pi1_value_test0
								,pi2_value_test0,count2_test0
								,pi2_value_test1,count2_test1
								,pi2_value_test2,count2_test2
								,pi2_value_test3,count2_test3
								,pi2_value_test4,count2_test4
								,pi2_value_test5,count2_test5
								,pi2_value_test6,count2_test6
								,pi2_value_test7,count2_test7;*/
	output [3:0] state0,next_state0,state1,next_state1,state2,next_state2,state3,next_state3,state4,next_state4,state5,next_state5,state6,next_state6,state7,next_state7;
	wire data_ready0, data_ready1, data_ready2, data_ready3, data_ready4, data_ready5, data_ready6, data_ready7;
	output done0, done1, done2, done3, done4, done5, done6, done7;
	reg[2:0] off_1,off_2,off_3,off_4,off_5,off_6,off_7,off_0;
	
	
	interleaver interleaver0 (data_in[0], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[0], data_ready0, done0, off_0,state0,next_state0,data_in_port0,r1_wetest0,/*count1_test0,pi1_value_test0,pi2_value_test0,count2_test0*/,counter1_reset0);
	interleaver interleaver1 (data_in[1], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[1], data_ready1, done1, off_1,state1,next_state1,data_in_port1,r1_wetest1,/*count1_test1,pi1_value_test1,pi2_value_test1,count2_test1*/,counter1_reset1);
	interleaver interleaver2 (data_in[2], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[2], data_ready2, done2, off_2,state2,next_state2,data_in_port2,r1_wetest2,/*count1_test2,pi1_value_test2,pi2_value_test2,count2_test2*/,counter1_reset2);
	interleaver interleaver3 (data_in[3], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[3], data_ready3, done3, off_3,state3,next_state3,data_in_port3,r1_wetest3,/*count1_test3,pi1_value_test3,pi2_value_test3,count2_test3*/,counter1_reset3);
	interleaver interleaver4 (data_in[4], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[4], data_ready4, done4, off_4,state4,next_state4,data_in_port4,r1_wetest4,/*count1_test4,pi1_value_test4,pi2_value_test4,count2_test4*/,counter1_reset4);
	interleaver interleaver5 (data_in[5], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[5], data_ready5, done5, off_5,state5,next_state5,data_in_port5,r1_wetest5,/*count1_test5,pi1_value_test5,pi2_value_test5,count2_test5*/,counter1_reset5);
	interleaver interleaver6 (data_in[6], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[6], data_ready6, done6, off_6,state6,next_state6,data_in_port6,r1_wetest6,/*count1_test6,pi1_value_test6,pi2_value_test6,count2_test6*/,counter1_reset6);
	interleaver interleaver7 (data_in[7], clk, reset, CRC_start, CRC_blocksize, CRC_end, data_out[7], data_ready7, done7, off_7,state7,next_state7,data_in_port7,r1_wetest7,/*count1_test7,pi1_value_test7,pi2_value_test7,count2_test7*/,counter1_reset7);
	
	and (data_ready, data_ready0, data_ready1, data_ready2, data_ready3, data_ready4, data_ready5, data_ready6, data_ready7);
	and (done, done0, done1, done2, done3, done4, done5, done6, done7);
	
	initial begin
		off_0 =  3'd0;
			off_1 =  3'd3;
			off_2 =  3'd2;
			off_3 =  3'd5;
			off_4 =  3'd4;
			off_5 =  3'd7;
			off_6 =  3'd6;
			off_7 =  3'd1;
	end
	
	always @(posedge clk)begin
		if((next_state0==4'b0001)|| (next_state0==4'b1001))begin // || (next_state0=4'b1001)
		
			off_0 =  3'd0;
			off_1 =  3'd3;
			off_2 =  3'd2;
			off_3 =  3'd5;
			off_4 =  3'd4;
			off_5 =  3'd7;
			off_6 =  3'd6;
			off_7 =  3'd1;
		end
		else if (next_state0==4'b0101) begin
			off_0 =  3'd0;
			off_1 =  3'd7;
			off_2 =  3'd6;
			off_3 =  3'd5;
			off_4 =  3'd4;
			off_5 =  3'd3;
			off_6 =  3'd2;
			off_7 =  3'd1;
		end
		else begin
			off_0 =  3'd0;
			off_1 =  3'd1;
			off_2 =  3'd2;
			off_3 =  3'd3;
			off_4 =  3'd4;
			off_5 =  3'd5;
			off_6 =  3'd6;
			off_7 =  3'd7;
		end
	end
endmodule