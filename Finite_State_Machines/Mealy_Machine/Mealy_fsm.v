`timescale 1ns / 1ps

module Mealy_fsm(
    input clk,
    input rst_n,        // Active-low reset
    input [1:0]in_bit,       // Input Bit
    output reg [1:0]out_bit      // Output Bit
    );
    
    // Encoded States
    localparam STATE_IDLE = 2'b00;
    localparam STATE_A = 2'b01;
    localparam STATE_B = 2'b10;
    
    // Internal Connections
    reg [1:0] current_state, next_state;
    
    // State Register Logic Block
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) current_state <= STATE_IDLE;
        else current_state <= next_state;
    end
    
    // Next State Logic Block
    always @(*) begin
        next_state = current_state; // The default pre assignment of state to avoid latch
        
        case(current_state)
            STATE_IDLE: begin
                if(in_bit == 2'b01) next_state = STATE_A;
                else if(in_bit == 2'b10) next_state = STATE_B;
                else next_state = STATE_IDLE;
            end
            STATE_A: begin
                if(in_bit == 2'b10) next_state = STATE_B;
                else if(in_bit == 2'b11) next_state = STATE_A;
                else next_state = STATE_IDLE;
            end
            STATE_B: begin
                if(in_bit == 2'b01) next_state = STATE_A;
                else if(in_bit == 2'b11) next_state = STATE_B;
                else next_state = STATE_IDLE;
            end
            default: next_state = STATE_IDLE;
        endcase
    end
    
    
    // Output Logic Block
    always @(*) begin
        case(current_state)
            STATE_IDLE: out_bit = 2'b00;
            STATE_A: begin
                if(in_bit == 2'b11) out_bit = 2'b11;
                else out_bit = 2'b01;
            end
            STATE_B: begin
                if(in_bit == 2'b11) out_bit = 2'b11;
                else out_bit = 2'b10;
            end
            default:    out_bit = 2'b00;
        endcase
    end
endmodule