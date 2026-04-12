`timescale 1ns / 1ps

module logic_unit(
    input [3:0] a,
    input [3:0] b,
    input [1:0] sel,
    output reg [3:0] y
    );
    
    always @(*) begin
        case(sel)
            0: y = a | b;       // OR logic
            1: y = a & b;       // AND logic
            2: y = a ^ b;       // XOR  logic
            3: y = ~(a | b);    // NOR logic
        endcase
    end
endmodule
