`timescale 1ns / 1ps

module gray_to_binary_tb;
    
    // Parameters
    parameter WIDTH = 4;
    
    // Initiation of input and douput pins
    logic [WIDTH-1:0]inp_data;
    logic [WIDTH-1:0]op_data;
    
    // Instantiation of uut
    gray_to_binary_top #(.WIDTH(WIDTH)) uut(.*);
    
    initial begin
        $display("----------------------------------");
        $display("Starting Gray to Binary Simulation");
        $display("----------------------------------");
        
        for(int i = 0; i < (1 << WIDTH); i++) begin
            inp_data = i;
            #10;
            $display("Time = %0d ns, Gray = %b | Binary = %b (%2d)", $time, inp_data, op_data, op_data);
        end
        $display("----------------------------------");
        $display("        Simulation Ended          ");
        $display("----------------------------------");
        $finish;
    end
endmodule
