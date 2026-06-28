`timescale 1ns / 1ps

module Moore_fsm_tb;

    reg clk;
    reg rst_n;
    reg in_bit;
    wire [1:0]out_bit;
    
    // Initiate the test unit
    Moore_fsm test_fsm(
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
        in_bit = 0;
        #2;
        
        // Applying reset
        rst_n = 0; // Reset enabled
        #10;
        rst_n = 1; // Reset disabled
        
        @(negedge clk); // Waiting for synchronisation
        
        // providing input to see the change of output state from STATE_IDLE TO STATE_A
        in_bit = 1;
        #10; // Waiting for a whole clock cycle to see the change
        
        // keeping the same input to see the change from STATE_A to STATE_B
        in_bit = 1;
        #10; // Watiting another clock cycle to see the change
        
        // Changing the input to 0 to see if it hits back to IDLE state
        in_bit = 0;
        #10; // Watiting a full clock cycle to see
        
        // See if the reset works in the middle of the process.
        in_bit = 1;
        #10;
        rst_n = 0; // Enabling the reset (Active low)
        #10;
        rst_n = 1; // Disabling the reset (Active low)
        
        #20;
        $display("END OF SIMULATION");
        $finish;
    end
endmodule