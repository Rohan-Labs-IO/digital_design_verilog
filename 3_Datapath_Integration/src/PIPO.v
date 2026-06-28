`timescale 1ns/1ps

module PIPO #(parameter WIDTH=4)(
    input reset,
    input clk,
    input load,
    input [WIDTH-1:0] parallel_in, // parallel intput
    output reg [WIDTH-1:0] parallel_out // parallel output
    );
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            parallel_out <= {WIDTH{1'b0}};  // WIDTH here defines the number of bits we need
        end else begin
            if (load) begin
                parallel_out <= parallel_in;
            end
            // Implicitly holds parallel_out <= parallel_out if load is 0
        end
    end
endmodule