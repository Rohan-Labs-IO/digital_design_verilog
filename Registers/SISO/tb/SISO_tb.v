`timescale 1ns / 1ps

module SISO_tb;
    
    // basic signals for the test
    reg clk;
    reg reset;
    reg si;
    wire so;
    
    // hooking up the Unit Under Test (uut)
    SISO uut(
        .clk(clk),
        .reset(reset),
        .si(si),
        .so(so)
    );
    
    // making the clock flip every 10ns (20ns period)
    always #10 clk = ~clk;
    
    initial begin
        // setup initial values so nothing starts as 'x'
        clk = 0;
        reset = 1;
        si = 0;
        
        // hold reset for a bit to make sure it clears
        #20; reset = 0;
        
        // feeding in our 1-0-1-1 pattern
        // using @(posedge clk) so the data changes right on the edge
        @(posedge clk); si = 1;
        @(posedge clk); si = 0;
        @(posedge clk); si = 1;
        @(posedge clk); si = 1;
        
        // stop sending data, just put zeros back in
        @(posedge clk); si = 0;

        // since it's a 4-bit register, we gotta wait a few cycles 
        // to actually see the sequence come out the other side (SO)
        repeat (5) @(posedge clk);
        
        $display("Simulation Finished");
        $finish; // stop the simulation or it will run forever
    end

    // printing everything to the console whenever something changes
    initial begin
        $monitor("Time=%0t, Reset=%b, SI=%b, SO=%b", $time, reset, si, so);
    end
endmodule