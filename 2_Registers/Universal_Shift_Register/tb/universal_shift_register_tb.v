`timescale 1ns / 1ps

module universal_shift_register_tb;
    // Inputs
    reg clk;
    reg reset;
    reg [1:0]select;
    reg si_left;      // For right shifting
    reg si_right;     // For left shifting
    reg [3:0] pi;
    // Outputs
    wire so;
    wire [3:0] po;
    
    universal_shift_register uut(
        .clk(clk),
        .reset(reset),
        .select(select),
        .si_left(si_left),
        .si_right(si_right),
        .pi(pi),
        .so(so),
        .po(po)
    );
    
    // Initiating the clock pulse
    always #5 clk = ~clk;
    
    // Initialising the test
    initial begin
        // all values ot zero
        clk = 0;
        reset = 1;
        select = 2'b00;
        si_left = 0;
        si_right = 0;
        pi = 4'b0000;
        
        #20; reset = 0; // Putting reset to zero
        
        //------------TEST 1(PARALLEL LOAD) --------------------
        @(negedge clk); select = 2'b11; pi = 4'b1001;
        $display("Testing Parallel Load. Expected: 1001");
        
        //------------TEST 2(HOLD) --------------------
        @(negedge clk); select = 2'b00;
        $display("Testing Hold. Expected: 1001");
        
        //------------TEST 3(RIGHT SHIFTING) --------------------
        @(negedge clk); select = 2'b01; si_left = 1;
        $display("Testing Right Shifting. Expected: Getting filled with 1s");
        #40; // Expecting the vallue to get filled up with 1s
        
        //------------TEST 4(LEFT SHIFTING) --------------------
        @(negedge clk); select = 2'b10; si_right = 0;
        $display("Testing Left Shifting. Expected: Getting filled with 0s");
        #40; // Expecting the vallue to get filled up with 0s
        
        //------------TEST 5(SERIAL OUTPUT) --------------------
        @(negedge clk); 
        $display("Testing Serial Out Logic");
        select = 2'b11; pi = 4'b0110;
        
        @(negedge clk); select = 2'b01;
        #20; // Observing the right shift
        
        @(negedge clk); select = 2'b11; pi = 4'b0110;
        
        @(negedge clk); select = 2'b10;
        #20; // Observing the left shift
        
        @(negedge clk); select = 2'b00;
        #20; // See the hold value
        
        $finish;
    end
endmodule
