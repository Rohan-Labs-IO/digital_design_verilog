`timescale 1ns / 1ps

module datapath_tb;

    reg clk;
    reg reset;
    reg load_inputs; // Loads both the inputs
    reg load_output; // Load both the outputs
    reg [3:0]a; // Input in A
    reg [3:0]b; // Input in B
    reg [3:0]select; // ALU operation selector
    
    // Output
    wire [7:0]final_result;
    
    datapath_top uut(
        .clk(clk),
        .reset(reset),
        .load_inputs(load_inputs),
        .load_output(load_output),
        .a(a),
        .b(b),
        .select(select),
        .final_result(final_result)
    );
    
    // Initialize clock to 0 so it toggles predictably (0 -> 1 at #5, #15, #25)
    initial begin
        clk = 0;
    end
    
    // Clock generation
    always #5 clk = ~clk;
    
    initial begin
        // Initialising all the inputs
        reset = 1;
        load_inputs = 0;
        load_output = 0;
        a = 0;
        b = 0;
        select = 0;
        
        // holding the reset for 20 ns
        #20; reset = 0; #10;
        
        // Test for addition
        $display("Test 1: Addition");
        a = 4'd5;
        b = 4'd3;
        select = 4'd0;
        load_inputs = 1; // Registers are enabled
        
        #10; // watiting for positive clock edge
        load_inputs = 0; // Input registers put to hold the value
        load_output = 1; // Output register is enabled
        
        #10; // waiting for positive clock edge
        load_output = 0; // Output register is put to hold the value
        
        #2; // Small delay to let output settle in simulation
        if(final_result == 8'd8)
            $display("SUCCESS: 5 + 3 = %d", final_result);
        else
            $display("ERROR: expected 8, got %d", final_result);
            
            
            
        // Test for multiplication
        $display("Test 2: Multiplication");
        a = 4'd4;
        b = 4'd7;
        select = 4'd2;
        load_inputs = 1; // Registers are enabled
        
        #10; // watiting for positive clock edge
        load_inputs = 0; // Input registers put to hold the value
        load_output = 1; // Output register is enabled
        
        #10; // waiting for positive clock edge
        load_output = 0; // Output register is put to hold the value
        
        #2; // Small delay to let output settle in simulation
        if(final_result == 8'd28)
            $display("SUCCESS: 4 * 7 = %d", final_result);
        else
            $display("ERROR: expected 28, got %d", final_result);
        
        
        // Test for subtraction
        $display("Test 1: Subtraction");
        a = 4'd5;
        b = 4'd3;
        select = 4'd1;
        load_inputs = 1; // Registers are enabled
        
        #10; // watiting for positive clock edge
        load_inputs = 0; // Input registers put to hold the value
        load_output = 1; // Output register is enabled
        
        #10; // waiting for positive clock edge
        load_output = 0; // Output register is put to hold the value
        
        #2; // Small delay to let output settle in simulation
        if(final_result == 8'd2)
            $display("SUCCESS: 5 - 3 = %d", final_result);
        else
            $display("ERROR: expected 2, got %d", final_result);
            
            
        // Test for comparison
        $display("Test 1: comparison");
        a = 4'd4;
        b = 4'd6;
        select = 4'd3;
        load_inputs = 1; // Registers are enabled
        
        #10; // watiting for positive clock edge
        load_inputs = 0; // Input registers put to hold the value
        load_output = 1; // Output register is enabled
        
        #10; // waiting for positive clock edge
        load_output = 0; // Output register is put to hold the value
        
        #2; // Small delay to let output settle in simulation
        if(final_result == 8'd1)
            $display("SUCCESS: 4 < 6 = %d", final_result);
        else
            $display("ERROR: expected 1, got %d", final_result);
        
        $finish;
    end
endmodule