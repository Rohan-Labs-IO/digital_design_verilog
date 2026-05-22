`timescale 1ns/1ps

module Mealy_fsm_tb;

    reg clk;
    reg rst_n;
    reg [1:0]in_bit;
    wire [1:0]out_bit;
    
    // Initiate the test unit
    Mealy_fsm test_fsm(
        .clk(clk),
        .rst_n(rst_n),
        .in_bit(in_bit),
        .out_bit(out_bit)
    );
    
    // Clock generation
    always #5 clk = ~clk; // Each complete clock cycle of 10ns.
    
    initial begin
        clk = 0;
        rst_n = 1;
        in_bit = 2'b00;
        #2;
        
        // Applying reset
        rst_n = 0; // Reset enabled
        #10;
        rst_n = 1; // Reset disabled
        
        @(negedge clk); // Waiting for the first falling edge after reset clears
        
        // Providing input to see the change of output state from STATE_IDLE TO STATE_A
        in_bit = 2'b01;
        #10; // Waiting for a whole clock cycle to see the change
        
        // Changing the input to see if the output stays in STATE_A with differetn output
        in_bit = 2'b11;
        #10;  // waiting for a whole clock cyle
        
        // keeping the same input to see the change from STATE_A to STATE_B
        in_bit = 2'b10;
        #10; // Watiting another clock cycle to see the change
        
        // Changing the input to see if the output stays in STATE_B with differetn output
        in_bit = 2'b11;
        #10;  // waiting for a whole clock cyle
        
        // Changing the input to 0 to see if it hits back to IDLE state
        in_bit = 0;
        #10; // Watiting a full clock cycle to see
        
        // Providing input to see the change of output state from STATE_IDLE TO STATE_B
        in_bit = 2'b10;
        #10; // Waiting for a whole clock cycle to see the change
        
        // See if the reset works in the middle of the process.
        rst_n = 0; // Enabling the reset (Active low)
        #10;
        rst_n = 1; // Disabling the reset (Active low)
        
        #20;
        $display("END OF SIMULATION");
        $finish;
    end
endmodule