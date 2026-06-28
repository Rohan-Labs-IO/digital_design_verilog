`timescale 1ns / 1ps

module SIPO(
    input clk,
    input reset,
    input si,
    output [3:0] po
    );
    
    reg [3:0] q;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;      // Clear register
        end else begin
            q <= {q[2:0], si}; // Shift left & insert new bit
        end
    end

    assign po = q;             // Drive parallel output
endmodule