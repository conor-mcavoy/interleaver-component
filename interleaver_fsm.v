
module interleaver_fsm(clk,reset,block_size,CRC_start,CRC_data,ready,done);
		input clk, reset;
		input block_size;
		input CRC_start;
		input CRC_data;
		output ready;
		output done;


reg[2:0] next_state,current_state;
reg w_reset,r_reset,output_mux,write_enable;
wire[15:0] w_counter,r_counter;
reg ready_r, done_r;
always @ (posedge clk ) begin
	if(reset) current_state <= 3'b000;
	else current_state <= next_state;
end 

always @(*) begin
	current_state = 3'b000;
	 ready_r = 1'b0;
	done_r = 1'b0;
	case (current_state)
	3'b000:
		begin
			if(block_size && CRC_start) begin
				next_state <= 3'b001;
			end
			else if (!block_size && CRC_start)begin
				next_state <= 3'b010;
			end
			else begin
				next_state <= 3'b000;
			end
		end
	3'b001:
		begin
			write_enable <= 1'b1;
			if(w_counter == 6144)begin
				next_state <= 3'b011;
			end
			else begin
				next_state <= 3'b001;
			end
		end
	3'b010:
		begin
			write_enable <= 1'b1;
			if(w_counter == 1056) begin
				next_state <= 3'b100;
			end
			else begin
				next_state <= 3'b010;
			end
		end
	3'b011:
		begin
			write_enable <= 1'b0;
			output_mux = 1'b0;
			ready_r <= 1'b1;
			if(r_counter == 1056) begin
				next_state <= 3'b101;
			end
			else begin
				next_state <= 3'b011;
			end
		end
	3'b100:
		begin
			write_enable <= 1'b0;
			output_mux = 1'b1;
			ready_r <= 1'b1;
			if(r_counter == 1056) begin
				next_state <= 3'b101;
			end
			else begin
				next_state <=3'b100;
			end
		end
	3'b101:
		begin
			write_enable <= 1'b0;
			ready_r <= 1'b0;
			done_r <= 1'b1;
			next_state <= 3'b000;
		end
	endcase
end

counter write_counter(clk,w_reset,w_counter);
counter read_counter(clk,r_reset,r_counter);
assign done = done_r;
assign ready = ready_r;
endmodule