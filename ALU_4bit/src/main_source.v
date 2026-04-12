// ALU Operation Table:
// 0: OR
// 1: AND
// 2: XOR
// 3: NOR
// 4: ADD
// 5: SUB
// 6: MUL
// 7: COMPARE


`timescale 1ns / 1ps

module main_source(
    input [3:0] a,          // $ bit input
    input [3:0] b,          // 4 bit input
    input [3:0] opcode,     // operation instruction
    output [7:0] result,    // final result
    output c,               // Carry checking 
    output v,               // Overflow checking
    output z,               // Zero state checking
    output s                // sign check
    );
    
    wire [3:0] add_sub_out;
    wire [3:0] logic_out;
    wire [7:0] mul_out;
    wire gt, lt, eq; // for the comparator logic
    wire c_add, v_add, z_add, s_add;
    
    reg mode;       // for the mode selection in add_subtractor unit
    reg [1:0]sel;        // for the select line of the logic unit
    reg [7:0] final_result;
    
    adder_subtractor add_sub(
        .a(a),
        .b(b),
        .y(add_sub_out),
        .mode(mode),
        .c(c_add),
        .v(v_add),
        .s(s_add),
        .z(z_add)
    );
    
    comparator comp(
        .a(a),
        .b(b),
        .greater(gt),
        .lesser(lt),
        .equal(eq)
    );
    
    logic_unit lu(
        .a(a),
        .b(b),
        .y(logic_out),
        .sel(sel)
    );
    
    multiplier mul(
        .a(a),
        .b(b),
        .y(mul_out)
    );
    
    
    always @(*) begin
        sel = 2'b00; mode = 1'b0; final_result = 8'b0;
        case(opcode)
            4'd0: begin sel = 2'd0; final_result = {4'b0000, logic_out}; end /// logical outputs 
            4'd1: begin sel = 2'd1; final_result = {4'b0000, logic_out}; end
            4'd2: begin sel = 2'd2; final_result = {4'b0000, logic_out}; end
            4'd3: begin sel = 2'd3; final_result = {4'b0000, logic_out}; end
            4'd4: begin mode = 0; final_result ={4'b0000, add_sub_out}; end
            4'd5: begin mode = 1; final_result ={4'b0000, add_sub_out}; end
            4'd6: final_result = mul_out;
            4'd7: final_result = (gt)? 8'd2 : (lt) ? 8'd1 : 8'd0;
            default: final_result = 8'b0;
        endcase
    end
    assign result = final_result;
    assign c = (opcode == 4'd4 || opcode == 4'd5) ? c_add : 1'b0;
    assign v = (opcode == 4'd4 || opcode == 4'd5) ? v_add : 1'b0;
    assign z = (opcode == 4'd4 || opcode == 4'd5) ? z_add : 1'b0;
    assign s = (opcode == 4'd4 || opcode == 4'd5) ? s_add : 1'b0;
endmodule
