`timescale 1ns / 1ps

module gray_to_binary_top #(
    parameter WIDTH = 4
    )(
    input [WIDTH-1:0]inp_data,
    output reg [WIDTH-1:0]op_data
    );
    
    integer i;
    
    always @(*) begin
        op_data[WIDTH-1] = inp_data[WIDTH-1];
        for(i=(WIDTH - 2); i>=0; i=i-1) begin
            op_data[i] = inp_data[i] ^ op_data[i+1];
        end
    end
endmodule
