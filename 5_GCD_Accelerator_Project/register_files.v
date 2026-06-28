`timescale 1ns / 1ps

module register_files(
    input clk,
    input reset,
    input write_en, // enabling write option
    input [2:0]r_add1, // Address of those 8 registers in 3 bit
    input [2:0]r_add2,
    input [2:0]w_add,
    input [15:0]w_data, // Data input to write
    
    output [15:0]r_data1, // Readable data
    output [15:0]r_data2
    );
    
    reg [15:0]reg_file [7:0]; // 8 registers with each having 16 bit capability
    integer i;
    
    // Async Read
    assign r_data1 = reg_file[r_add1];
    assign r_data2 = reg_file[r_add2];
    
    // Sync Write
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 8; i = i + 1) begin
                reg_file[i] <= 16'h0000;
            end
        end else if (write_en) reg_file[w_add] <= w_data;
    end
endmodule