`timescale 1ns / 1ps

module SIPO_tb;
    reg clk;
    reg reset;
    reg si;
    wire [3:0] po;
    
    SIPO uut (
        .clk(clk),
        .reset(reset),
        .si(si),
        .po(po)
    );
    
    // Clock generation: 20ns period
    always #10 clk = ~clk;
    
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        si = 0;
        
        #20 reset = 0; // Release reset
        
        // Input sequence: 1, 0, 1, 1
        @(posedge clk); si = 1;
        @(posedge clk); si = 0;
        @(posedge clk); si = 1;
        @(posedge clk); si = 1;
        
        // Clear input and wait for shift to complete
        @(posedge clk); si = 0;
        repeat(5) @(posedge clk);
        
        $display("Simulation Finished");
        $finish; 
    end
endmodule