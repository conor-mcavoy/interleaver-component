module interleaver_fsm(clk,reset,block_size,CRC_start,CRC_data,ready,done);
		input clk, reset;
		input block_size;
		input CRC_start;
		input CRC_data;
		output ready;
		output done;


reg[3:0] next_state,current_state;
reg w_reset,r_reset,output_mux,write_enable;
wire[15:0] w_counter,r_counter;
reg ready_r, done_r;
always @ (posedge clk ) begin
	if(reset) current_state <= 4'b0000;
	else current_state <= next_state;
end 

always @(*) begin
	ready_r = 1'b0;
	done_r = 1'b0;
	p1mode = 1'b0;
	p2mode = 1'b0;
	ctr1_re= 1'b0;
	ctr2_re= 1'b0;
	ctr1_en= 1'b0;
	ctr2_en= 1'b0;
	ram1_we=1'b0;
	ram2_we=1'b0;
	case (current_state)
	4'b0000: 
		begin
			p1mode = 1'b0;
			p2mode = 1'b0;
			ctr1_en= 1'b0;
			ctr2_en= 1'b0;
			ram1_we=1'b0;
			ram2_we=1'b0;
			if(!block_size && CRC_start) begin
				next_state <= 4'b0001;
				ctr1_re <= 1'b1;
			end
			else if (block_size && CRC_start)begin
				next_state <= 4'b0010;
				ctr1_re <= 1'b1;
			end
			else begin
				next_state <= 4'b0000;
			end
		end
	
	4'b0001:
		begin
			p1mode = 1'b0;
			p2mode = 1'b0;
			ctr1_en= 1'b1;
			ctr2_en= 1'b0;
			ram1_we=1'b0;
			ram2_we=1'b0;
			if(r_counter_1 == 1056) begin
				next_state <= 4'b0111;
				ctr1_re <= 1'b1;
			end
			else begin
				next_state <= 4'b0001;
			end
		end
	
	4'b0010:
		begin
			p1mode = 1'b0;
			p2mode = 1'b0;
			ctr1_en= 1'b1;
			ctr2_en= 1'b0;
			ram1_we=1'b0;
			ram2_we=1'b0;
			if(r_counter_1 == 6144) begin
				if(block_size)begin
					next_state <= 4'0100;
					ctr1_re <=1'b1;
					ctr2_re<=1'b1;
				end
				else begin
					next_state <= 4'0110;
					ctr1_re <= 1'b1;
					ctr2_re <=1'b1;
				end
			end
			else begin
				next_state <= 4'b0010;
			end
		end
		
	4'b0011:
		begin
			p1mode = 1'b0;
			p2mode = 1'b1;
			ctr1_en= 1'b1;
			ctr2_en= 1'b1;
			ram1_we=1'b0;
			ram2_we=1'b1;
			if(END) begin
				next_state <= 4'1001;
				ctr1_re <= 1'b1;
			end
			else begin
			if(r_counter_1 == 6144) begin
				if(block_size)begin
					next_state <= 4'0100;
					ctr1_re <=1'b1;
					ctr2_re<=1'b1;
				end
				else begin
					next_state <= 4'0110;
					ctr1_re <=1'b1;
					ctr2_re<=1'b1;
				end
			end
			else begin
				next_state <= 4'b0010;
			end
			end
		end
	
	4'b0100:
		begin
			p1mode = 1'b1;
			p2mode = 1'b0;
			ctr1_en= 1'b1;
			ctr2_en= 1'b1;
			ram1_we=1'b1;
			ram2_we=1'b0;
			if(end)begin
				next_state <= 4'1010;
				ctr2_re <=1'b1;
			end
			else begin
				if(ctr_finished)begin
					if(block_size)begin
						next_state <= 4'0011;
						ctr1_re <=1'b1;
						ctr2_re<=1'b1;
					end
					else begin
						next_state<=4'0101;
						ctr1_re <=1'b1;
						ctr2_re<=1'b1;
					end
				end
				else begin
					next_state <=4'b0100;
				end
			end
		end
	4'b0101:
		begin
			p1mode = 1'b0;
			p2mode = 1'b1;
			ctr1_en= 1'b1;
			ctr2_en= 1'b1;
			ram1_we=1'b0;
			ram2_we=1'b1;
			if(ctr_finished)begin
				next_state <=4'b0111;
				ctr1_re <=1'b1;
			end	
			else begin
				next_state <=4'b0101;
			end
		end
	4'b0110:
		begin
			p1mode = 1'b1;
			p2mode = 1'b0;
			ctr1_en= 1'b1;
			ctr2_en= 1'b1;
			ram1_we=1'b1;
			ram2_we=1'b0;
			if(ctr_finished)begin
				next_state <=4'b1000;
				ctr2_re <=1'b1;
			end	
			else begin
				next_state <=4'b0110;
			end
		end
	4'b0111:
		begin
			p1mode = 1'b1;
			p2mode = 1'b0;
			ctr1_en= 1'b1;
			ctr2_en= 1'b0;
			ram1_we=1'b1;
			ram2_we=1'b0;
			if(ctr1_finished)begin
				next_state<=4'b1011;
			end
			else begin
				next_state <=4'b0111;
			end
		end
	4'b1000:
		begin
			p1mode = 1'b0;
			p2mode = 1'b1;
			ctr1_en= 1'b0;
			ctr2_en= 1'b1;
			ram1_we=1'b0;
			ram2_we=1'b1;
			if(ctr2_finished)begin
				next_state<=4'b1011;
			end
			else begin
				next_state <=4'b1000;
			end
		end
	4'b1001:
		begin
			p1mode = 1'b1;
			p2mode = 1'b0;
			ctr1_en= 1'b1;
			ctr2_en= 1'b0;
			ram1_we=1'b1;
			ram2_we=1'b0;
			if(ctr1_finished)begin
				next_state<=4'b1011;
			end
			else begin
				next_state <=4'b1001;
			end
		end
	4'b1010:
		begin
			p1mode = 1'b0;
			p2mode = 1'b1;
			ctr1_en= 1'b0;
			ctr2_en= 1'b1;
			ram1_we=1'b0;
			ram2_we=1'b1;
			if(ctr2_finished)begin
				next_state<=4'b1011;
			end
			else begin
				next_state <=4'b1010;
			end
		end
	4'b1011:
		begin	
			p1mode = 1'b0;
			p2mode = 1'b0;
			ctr1_en= 1'b0;
			ctr2_en= 1'b0;
			ram1_we=1'b0;
			ram2_we=1'b0;
			next_state<=4'b1010;
			ready_r=1'b1;
			done_r = 1'b1;
		end
	4'b1100:
		begin
			p1mode = 1'b0;
			p2mode = 1'b0;
			ctr1_en= 1'b0;
			ctr2_en= 1'b0;
			ram1_we=1'b0;
			ram2_we=1'b0;
			//wait for something .... go back to 0000
			next_state<=4'b0000;
		end
	endcase
end

counter write_counter_1(clk,w_reset_1,w_counter_1);
counter read_counter_1(clk,r_reset_1,r_counter_1);
counter write_counter_2(clk,w_reset_1,w_counter_2);
counter read_counter_2(clk,r_reset_1,r_counter_2);
assign done = done_r;
assign ready = ready_r;
endmodule