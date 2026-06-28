`timescale 1ns / 1ps

module pulse_synchronizer_tb;

    // Source clock domain
    logic clk_src;
    logic rst_n_src;
    logic pulse_in;
    
    // Destination Clock Domain
    logic clk_dst;
    logic rst_n_dst;
    logic pulse_out;
    
    // Instantiation of the Device Under Test
    pulse_synchronizer dut(.*);
    
    // Clock Periods
    // ***This can be used to change the clock ration to check different cases ***
    localparam SRC_CLK_DURATION = 10;
    localparam DST_CLK_DURATION = 25;
    
    // Intializing the Pulses
    // Source Clock
    initial begin
        clk_src = 1'b0;
        forever #(SRC_CLK_DURATION / 2.0) clk_src = ~clk_src;
    end
    // Destination Clock
    initial begin
        clk_dst = 1'b0;
        forever #(DST_CLK_DURATION / 2.0) clk_dst = ~clk_dst;
    end
    
    // Main Simulation Block
    initial begin
        pulse_in = 1'b0;
        rst_n_src = 1'b0;
        rst_n_dst = 1'b0;
        // Reset is turned on
        #(SRC_CLK_DURATION * 2);
        
        rst_n_src = 1'b1;
        rst_n_dst = 1'b1;
        $display("Time = %0t ns | Reset has been released", $time);
        #(SRC_CLK_DURATION * 4); // Reset is turned on
        
        // Test Case: A single pulse
        $display("-------------Test using a Single Pulse-------------");
        @(posedge clk_src);
        pulse_in = 1'b1;
        @(posedge clk_src);
        pulse_in = 1'b0;
        
        // Wait to see the whole transition through the 3 FF
        #(DST_CLK_DURATION * 6);
        
        // Test Case: Multiple pulses
        $display("-------------Test using a Multiple Pulses-------------");
        repeat (5) begin
            @(posedge clk_src);
            pulse_in = 1'b1;
            @(posedge clk_src);
            pulse_in = 1'b0;
            #(DST_CLK_DURATION * $urandom_range(5,10));
        end
        
        $display("Time = %0t ns | Simulation Ended", $time);
        $finish;
    end
    
    // Monitoring the Signals
    initial begin
        fork
            forever begin
                @(posedge clk_src);
                if (pulse_in) $display("Time = %0t ns | >>>>> SRC <<<<< | Pulse Generated", $time);
            end
            forever begin
                @(posedge clk_dst);
                if (pulse_out) $display("Time = %0t ns | >>>>> DST <<<<< | Pulse Synchronised Successfully", $time);
            end
        join
    end
endmodule
