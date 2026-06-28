// A Four Way Traffic Light Controller 

module traffic_light_controller_top #(
	// This default value of second limit is set for real hardware simulation (50 MHz)
	parameter ONE_SECOND_LIIMIT = 26'd49_999_999
)(
	input clk,
	input rst_n,	   // Active low reset
	output reg [2:0]N_light,   // North Side Light
	output reg [2:0]S_light,    // South Side Light
	output reg [2:0]E_light,   // East Side Light
	output reg [2:0]W_light,    // West Side Light
	output reg [2:0]NE_light,   // North to East Light
	output reg [2:0]NW_light,    // North to West Light
	output reg [2:0]SE_light,   // South to East Light
	output reg [2:0]SW_light,    // South to West Light
	output reg [2:0]EN_light,   // East to North Light
	output reg [2:0]ES_light,    // East to South Light
	output reg [2:0]WN_light,   // West to North Light
	output reg [2:0]WS_light    // West to South Light
	);
	

	// State light code
	localparam green = 3'b001,
		   yellow = 3'b010,
		   red = 3'b100;
	

	// States needed for this problem
	localparam s0 = 4'b0000,	// All RED
		   s1 = 4'b0001,	// Cars from N, S, NE, SW is GREEN, rest is RED.
		   s2 = 4'b0010,	// Cars from N, S, NE, SW is YELLOW, rest is RED.
		   s3 = 4'b0011,	// Cars from N, NW is GREEN, rest is RED.
		   s4 = 4'b0100,	// Cars from N, NW is YELLOW, rest is RED.
		   s5 = 4'b0101,	// Cars from S, SE is GREEN, rest is RED.
		   s6 = 4'b0110,	// Cars from S, SE is YELLOW, rest is RED.
		   s7 = 4'b0111,	// Cars from E, W, ES, WN is GREEN, rest is RED.
		   s8 = 4'b1000,	// Cars from E, W, ES, WN is YELLOW, rest is RED.
		   s9 = 4'b1001,	// Cars from E, EN is GREEN, rest is RED.
		   s10 = 4'b1010,	// Cars from E, EN is YELLOW, rest is RED.
		   s11 = 4'b1011,	// Cars from W, WS is GREEN, rest is RED.
		   s12 = 4'b1100;	// Cars from W, WS is YELLOW, rest is RED.

	
	// Timer for Green, Yellow and Red light, Initialised as one count lower than the desired time duration
	// To compensate the FSM transation time when it reaches 0
	localparam green_main_timer = 4'd14,    // Effective 15 sec of timer duration
		   green_side_timer = 4'd9,	// Effective 10 sec of timer duration
		   yellow_timer = 4'd2,		// Effective 3 sec of timer duration
		   red_timer = 4'd1;		// Effective 2 sec of timer duration

	// Internal Signals
	reg [3:0]timer;
	reg [3:0] next_state, current_state, prev_state;
	wire second_check; 	// Checks whether 1 second is counted

	// 1. Timer logic with 1 sec count, for a general 50MHz clock
	reg [25:0]clk_counter;
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) clk_counter <= 26'd0;
		else if (clk_counter == ONE_SECOND_LIIMIT) clk_counter <= 26'd0;
		else clk_counter <= clk_counter + 1'b1;
	end

	assign second_check = (clk_counter == ONE_SECOND_LIIMIT);

	// 2. Setting timer anc clock logic
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) timer <= red_timer;
		else if(second_check) begin
			if (timer == 4'd0) begin
				case(next_state)
					s1, s7: timer <= green_main_timer;
					s3, s5, s9, s11: timer <= green_side_timer;
					s2, s4, s6, s8, s10, s12: timer <= yellow_timer;
					s0: timer <= red_timer;
					default: timer <= red_timer;
				endcase
			end
			else timer <= timer - 1'b1;
		end
		//else timer <= timer - 1'b1;
	end

	// 3. Register logic
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin 
			current_state <= s0;
			prev_state <= s12; // Start with this default value
			//timer <= red_timer; // To reset the timer properly
		end
		else begin 
			current_state <= next_state;
			if(current_state == s2 || current_state == s4 || current_state == s6 || current_state == s8 ||
			   current_state == s10 || current_state == s12) prev_state <= current_state;
		end
	end

	// 4. Next State Logic
	always @(*) begin
		if (second_check && timer == 4'd0) begin	
			case(current_state)
				s0: begin
					case(prev_state)
						s2: next_state = s3;
						s4: next_state = s5;
						s6: next_state = s7;
						s8: next_state = s9;
						s10: next_state = s11;
						s12: next_state = s1;
						default: next_state = s1;
					endcase
				end

				// All the GREEN states -----> YELLOW states
				s1: next_state = s2;
				s3: next_state = s4;
				s5: next_state = s6;
				s7: next_state = s8;
				s9: next_state = s10;
				s11: next_state = s12;

				// All the YELLOW states ----> RED states
				s2, s4, s6, s8, s10, s12: next_state = s0;

				default: next_state = s0;
			endcase
		end
		else next_state = current_state;
	end	


	// 5. Output Logic
	always @(*) begin
		// Setting default of all to red
		N_light = red; S_light = red; E_light = red; W_light = red;
		NE_light = red;	NW_light = red; SE_light = red; SW_light = red;
		EN_light = red; ES_light = red; WS_light = red; WN_light = red;

		case(current_state)
			s0: begin 
				// Default state remains
			end
			s1: begin
				N_light = green; S_light = green; NE_light = green; SW_light = green;
			end
			s2: begin
				N_light = yellow; S_light = yellow; NE_light = yellow; SW_light = yellow;
			end
			s3: begin
				N_light = green; NW_light = green;
			end
			s4: begin
				N_light = yellow; NW_light = yellow;
			end
			s5: begin
				S_light = green; SE_light = green;
			end
			s6: begin
				S_light = yellow; SE_light = yellow;
			end
			s7: begin
				E_light = green; W_light = green; ES_light = green; WN_light = green;
			end
			s8: begin
				E_light = yellow; W_light = yellow; ES_light = yellow; WN_light = yellow;
			end
			s9: begin
				E_light = green; EN_light = green;
			end
			s10: begin
				E_light = yellow; EN_light = yellow;
			end
			s11: begin
				W_light = green; WS_light = green;
			end
			s12: begin
				W_light = yellow; WS_light = yellow;
			end
		endcase
	end
endmodule