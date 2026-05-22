`timescale 1ns / 1ps

module gcd_accelerator_tb;

    reg clk;
    reg reset;
    reg start;
    reg [15:0] inp_A;
    reg [15:0] inp_B;
    wire [15:0] final_output;
    wire done;
    
    gcd_accelerator uut (
        .clk(clk), .reset(reset), .start(start),
        .inp_A(inp_A), .inp_B(inp_B),
        .final_output(final_output), .done(done)
    );
    
    // Clock Generation
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        reset = 1;
        inp_A = 0;
        inp_B = 0;
        start = 0;
        
        #20; reset = 0; // waiting for 20 ns to let reset stay at 1
        
        // Test Case: GCD of 48 and 18 is 6
        #10;
        inp_A = 16'd48;
        inp_B = 16'd18;
        start = 1;
        #20 start = 0; // Pulse start
        
        @(posedge done);
        #1; // waiting for the output to stabilise
        if (final_output == 16'd6) 
        $display("SUCCESS: GCD is %d", final_output);
        else 
        $display("ERROR: Expected 6, got %d", final_output);

        #50 $finish;
    end
endmodule
