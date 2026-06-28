`timescale 1ns / 1ps

module ff2_synchronizer_tb;
    logic clk_dst;
    logic rst_n;
    logic async_in;
    logic sync_out;
    
    // Instantiation of uut
    ff2_synchronizer uut(.*);
    
    // Generate the destination clock
    always #5 clk_dst = ~clk_dst;
    
    // Generate a completely independent, asynchronous source clock
    logic clk_src;
    always #7.5 clk_src = ~clk_src;
    
    // Test simulation
    initial begin
        clk_dst = 1'b0;         // To start the clock with specified value
        clk_src = 1'b0;         // To start the clock with specified value
        async_in = 1'b0;
        rst_n = 1'b0;           // Enabling the active low reset
        
        #25; rst_n = 1'b1;      // Holding the enable for this time
        #10;
        
        $display("Reset released. Starting asynchronous stimulus.");
        
        // Driving the async_in with a different clock
        repeat(10) begin
            @(posedge clk_src);
            // Adding a random delay
            #($urandom_range(1,4));
            async_in = 1'b1;
            $display("At %0t ns: async_in driven to HIGH",$time);
            
            repeat ($urandom_range(3,6)) @(posedge clk_src);
            
            #($urandom_range(1,4));
            async_in = 1'b0;
            $display("At %0t ns: async_in driven to LOW",$time);
        end
        #100; // Letting the simulation run a little bit longer
        $display("Simulation Finished");
        $finish;
    end
    
    always @(posedge clk_dst) begin
        if(rst_n) begin
            $monitor("At %0t ns | clk_dst edge | async_in = %b | internal_q = %b | sync_out = %b",$time, async_in, uut.q, sync_out);
        end
    end
endmodule
