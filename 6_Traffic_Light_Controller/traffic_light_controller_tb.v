`timescale 1ns / 1ps

module traffic_light_controller_tb;
	reg clk;
	reg rst_n;

	wire [2:0]N_light;   // North Side Light
	wire [2:0]S_light;    // South Side Light
	wire [2:0]E_light;   // East Side Light
	wire [2:0]W_light;    // West Side Light
	wire [2:0]NE_light;   // North to East Light
	wire [2:0]NW_light;    // North to West Light
	wire [2:0]SE_light;   // South to East Light
	wire [2:0]SW_light;    // South to West Light
	wire [2:0]EN_light;   // East to North Light
	wire [2:0]ES_light;    // East to South Light
	wire [2:0]WN_light;   // West to North Light
	wire [2:0]WS_light;    // West to South Light

	traffic_light_controller_top #(
		.ONE_SECOND_LIIMIT(26'd499)	// Overriding actual value to get faster simulation
	)uut(
		.clk(clk), .rst_n(rst_n), 
		.N_light(N_light), .S_light(S_light), .E_light(E_light), .W_light(W_light),
		.NE_light(NE_light), .NW_light(NW_light), .SE_light(SE_light), .SW_light(SW_light),
		.EN_light(EN_light), .ES_light(ES_light), .WN_light(WN_light), .WS_light(WS_light)
	);

	// Clock generation
	always #10 clk = ~clk;  // Giving rise to 50 MHz clk frequency

	// Function to generate strings instead of numbers for better readablity
	function [47:0]decode_light (input [2:0]light);    	// 6*8 = 48  (8bit for each character)
		case(light)
			3'b001: decode_light = "GREEN";
			3'b010: decode_light = "YELLOW";
			3'b100: decode_light = "RED";
			default: decode_light = "RED";
		endcase
	endfunction

	initial begin
		clk = 0;
		rst_n = 0; // Reset is enabled	
		$display("Simulation Started");

		#50; rst_n = 1; // For 20ns it is kept on reset state.

		// 100 states * 10,000 ns per "second" = 1,000,000 ns
    		#1000000;

		$display("Simulation Ended");
		$finish;
	end

	// 6. Automated Monitor
    	initial begin
        	$monitor("Time: %0t | N: %s | S: %s | E: %s | W: %s | NE: %s | NW: %s | SE: %s | SW: %s | EN: %s | ES: %s | WN: %s | WS: %s", 
                 $time, 
                 decode_light(N_light), 
                 decode_light(S_light), 
                 decode_light(E_light), 
                 decode_light(W_light),
                 decode_light(NE_light), 
                 decode_light(NW_light), 
                 decode_light(SE_light), 
                 decode_light(SW_light),
                 decode_light(EN_light), 
                 decode_light(ES_light), 
                 decode_light(WN_light), 
                 decode_light(WS_light));
    	end
endmodule