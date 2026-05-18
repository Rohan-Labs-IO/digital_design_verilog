`timescale 1ns/1ps

module datapath_top(
    input clk,
    input reset,
    input load_inputs, // Loads both the inputs
    input load_output, // Load both the outputs
    
    input [3:0]a, // Input in A
    input [3:0]b, // Input in B
    input [3:0]select, // ALU operation selector
    output [7:0]final_result
    );
    
    // Interconnect Lines
    wire [3:0]reg_a_to_alu;
    wire [3:0]reg_b_to_alu;
    wire [7:0]alu_to_out_reg;
    
    PIPO #(.WIDTH(4)) reg_a(
        .reset(reset),
        .clk(clk),
        .load(load_inputs),
        .parallel_in(a),
        .parallel_out(reg_a_to_alu)
    );
    
    PIPO #(.WIDTH(4)) reg_b(
        .reset(reset),
        .clk(clk),
        .load(load_inputs),
        .parallel_in(b),
        .parallel_out(reg_b_to_alu)
    );
    
    alu alu1(
        .a(reg_a_to_alu),
        .b(reg_b_to_alu),
        .select(select),
        .result(alu_to_out_reg)
    );
    
    PIPO #(.WIDTH(8)) reg_out(
        .reset(reset),
        .clk(clk),
        .load(load_output),
        .parallel_in(alu_to_out_reg),
        .parallel_out(final_result)
    );
    
    
endmodule