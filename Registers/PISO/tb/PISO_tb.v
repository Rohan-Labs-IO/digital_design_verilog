`timescale 1ns / 1ps


module PISO_tb;
    // Inputs
    reg clk;
    reg load;
    reg reset;
    reg [3:0]pi;
    // Outputs
    wire so;
    
    PISO uut(
        .clk(clk),
        .load(load),
        .reset(reset),
        .pi(pi),
        .so(so)
    );
    
    // clock generation
    always #5 clk = ~clk;

    initial begin
        // --- Initialize Inputs ---
        clk = 0;
        reset = 1;
        load = 0;
        pi = 4'b0000;

        // --- Step 1: Reset the system ---
        #20 reset = 0;
        $display("Reset released at %t", $time);

        // --- Step 2: Load data (e.g., 1011) ---
        #10;
        pi = 4'b1011; 
        load = 1;
        #10; // Wait one clock cycle
        load = 0;
        $display("Data 1011 loaded. Starting shift...");

        // --- Step 3: Observe the Serial Output ---
        // Since it's a 4-bit register, we need at least 4 cycles
        #10; $display("Cycle 1: so = %b (Expected: 1)", so);
        #10; $display("Cycle 2: so = %b (Expected: 0)", so);
        #10; $display("Cycle 3: so = %b (Expected: 1)", so);
        #10; $display("Cycle 4: so = %b (Expected: 1)", so);
        #10; $display("Cycle 5: so = %b (Expected: 0 - empty)", so);

        // --- Step 4: Finish Simulation ---
        #50;
        $display("Simulation finished.");
        $finish;
    end
endmodule