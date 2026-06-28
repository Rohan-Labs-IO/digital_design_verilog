`timescale 1ns / 1ps


module PISO(
    input wire clk,          // Giving clock pulse
    input wire reset,        // Reset
    input wire load,         // To enable and disable when to take the input and when not
    input wire [3:0]pi,      // parallel input
    output reg so            // serial output
    );
    
    reg [3:0] shift_reg;   // Internal register to hold the value of pi
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 4'b0000;
            so <= 1'b0;
        end else if (load) begin
            shift_reg <= pi;
        end else begin
            // For left shift logic
//            so <= shift_reg[3];
//            shift_reg <= {shift_reg[2:0],1'b0};

            // For right shift logic
            so <= shift_reg[0];
            shift_reg <= {1'b0,shift_reg[3:1]};
        end
    end
endmodule