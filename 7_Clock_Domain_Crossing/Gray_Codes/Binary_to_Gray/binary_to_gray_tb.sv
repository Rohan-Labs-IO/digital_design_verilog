`timescale 1ns / 1ps

module binary_to_gray_tb;
    // Parameters
    parameter WIDTH = 4;
    
    // Initiation of input and douput pins
    logic [WIDTH-1:0]inp_data;
    logic [WIDTH-1:0]op_data;
    
    // Instanciation of UUT
    binary_to_gray_top #(.WIDTH(WIDTH)) uut(.*);
    
    
    initial begin
        $display("----------------------------------");
        $display("Starting Binary to Gray Simulation");
        $display("----------------------------------");
        
        // Decleration of loop
        for(int i = 0; i < (1 << WIDTH); i++) begin
            inp_data = i;
            #10; // Waiting for 10 ns
            $display("Time = %0d ns | Binary = %b (%2d) | Gray = %b", $time, inp_data, inp_data, op_data);
        end
        
        $display("----------------------------------");
        $display("        Simulation Ended          ");
        $display("----------------------------------");
        $finish;
    end 
endmodule
