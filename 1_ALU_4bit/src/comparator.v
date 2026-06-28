`timescale 1ns / 1ps

module comparator(
    input [3:0] a,
    input [3:0] b,
    output reg greater,
    output reg lesser,
    output reg equal
    );
    
    always @(*) begin
        greater = 1'b0;
        lesser = 1'b0;
        equal = 1'b0;
        
        if (a>b)
            greater = 1'b1;
        else if (a<b)
            lesser = 1'b1;
        else
            equal = 1'b1;
    end
endmodule
