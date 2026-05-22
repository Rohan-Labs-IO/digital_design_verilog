`timescale 1ns / 1ps

module gcd_accelerator(
    input clk,
    input reset,
    input start,
    input [15:0]inp_A,
    input [15:0]inp_B,
    output [15:0]final_output,
    output done
    );
    
    // Interconnect lines
    wire [2:0] r_add1, r_add2, w_add;
    wire [15:0] r_data1, r_data2;
    wire [15:0] comparator_output;
    wire write_en;
    wire [1:0] select;
    
    reg [15:0] w_data;
    
    // comapratator wires
    wire is_equal, is_greater;
    
    register_files registers(
        .clk(clk),
        .reset(reset),
        .write_en(write_en),
        .r_add1(r_add1),
        .r_add2(r_add2),
        .w_add(w_add),
        .w_data(w_data),
    
        .r_data1(r_data1),
        .r_data2(r_data2)
    );
    gcd_control controller(
        .clk(clk),
        .start(start), 
        .reset(reset),
        .is_equal(is_equal),
        .is_greater(is_greater),    
        .write_en(write_en),
        .r_add1(r_add1),
        .r_add2(r_add2),
        .w_add(w_add),
        .select(select),
        .done(done) 
    );
    
    // register logics
    always @(*) begin
        case (select)
            2'b01: w_data = inp_A;
            2'b10: w_data = inp_B;
            default: w_data = comparator_output;
        endcase
    end
    
    // Comparator logic
    assign comparator_output = is_greater ? (r_data1 - r_data2) : (r_data2 - r_data1);
    assign is_greater = (r_data1 > r_data2);
    assign is_equal = (r_data1 == r_data2);
    
    assign final_output = r_data1; // when done is 1, we get thsi result
endmodule