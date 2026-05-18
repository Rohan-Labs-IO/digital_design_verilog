`timescale 1ns / 1ps

module alu(
    input [3:0]a,
    input [3:0]b,
    input [3:0]select,
    output [7:0]result
    );
    
    reg [7:0]out;
    
    always @(*)begin
        out = 8'b0;
        case(select)
            4'd0: out = a+b; // Addition
            4'd1: out = a-b;// Subtraction
            4'd2: out = a*b;// Multiplication
            4'd3: out = (a>b)?8'd2 : (a<b)?8'd1 : 8'd0;// Comparison
            4'd4: out = a & b;// Bitwise And
            4'd5: out = a | b;// Bitwise Or
            4'd6: out = ~(a & b);// Bitwise Nand
            4'd7: out = a ^ b;// Bitwise Xor
            default: out = 8'b0; // default case
        endcase
    end
    assign result = out;
endmodule