module ram8 (clk, data_in0, data_in1, data_in2, data_in3, data_in4, data_in5, data_in6, data_in7,
                  write_addr0, /*write_addr1, write_addr2, write_addr3, write_addr4, write_addr5, write_addr6, write_addr7,*/
					   write_en,//0, write_en1, write_en2, write_en3, write_en4, write_en5, write_en6, write_en7,
						// I don't think multiple write enables are needed, we can just have everything write all at once
						read_addr0, read_addr1, read_addr2, read_addr3, read_addr4, read_addr5, read_addr6, read_addr7,
						data_out0, data_out1, data_out2, data_out3, data_out4, data_out5, data_out6, data_out7);
	// No reset: to discuss.
	// Is reset even necessary? We should never be asking for data from a register that has not been written to.
	input clk;
	input data_in0, data_in1, data_in2, data_in3, data_in4, data_in5, data_in6, data_in7;
	input [12:0] write_addr0/*, write_addr1, write_addr2, write_addr3, write_addr4, write_addr5, write_addr6, write_addr7*/;
	input write_en;
	input [12:0] read_addr0, read_addr1, read_addr2, read_addr3, read_addr4, read_addr5, read_addr6, read_addr7;
	
	output data_out0, data_out1, data_out2, data_out3, data_out4, data_out5, data_out6, data_out7;

   reg memory_array [8191:0];
	
	assign data_out0 = memory_array[read_addr0];
	assign data_out1 = memory_array[read_addr1];
	assign data_out2 = memory_array[read_addr2];
	assign data_out3 = memory_array[read_addr3];
	assign data_out4 = memory_array[read_addr4];
	assign data_out5 = memory_array[read_addr5];
	assign data_out6 = memory_array[read_addr6];
	assign data_out7 = memory_array[read_addr7];
//	initial begin
//		integer i;
//				for(i = 0; i < 8192; i = i + 1)
//					begin
//						memory_array[i] = 1'b0;
//					end
//	end
   always @(posedge clk) begin
		
		if (write_en) begin
			memory_array[write_addr0] = data_in0;
			memory_array[write_addr0+3'd1] = data_in1;
			memory_array[write_addr0+3'd2] = data_in2;
			memory_array[write_addr0+3'd3] = data_in3;
			memory_array[write_addr0+3'd4] = data_in4;
			memory_array[write_addr0+3'd5] = data_in5;
			memory_array[write_addr0+3'd6] = data_in6;
			memory_array[write_addr0+3'd7] = data_in7;
		end
   end
	
	// This design is a monstrosity and should have never been built probably. I will have to answer to God for this one.
endmodule