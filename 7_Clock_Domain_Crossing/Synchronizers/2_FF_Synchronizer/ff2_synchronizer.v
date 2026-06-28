`timescale 1ns / 1ps

module ff2_synchronizer(
    input clk_dst,          // Destination Clock domain
    input rst_n,            // Active low reset
    input async_in,         // Asynchronous input data
    output reg sync_out     // Synchronous output data
    );
    
    reg q;
    
    always @(posedge clk_dst or negedge rst_n) begin
        if(!rst_n) begin
            q <= 1'b0;
            sync_out <= 1'b0;
        end else begin
            q <= async_in;      // Captures the async input
            sync_out <= q;      // Provides a stable output
        end
    end
endmodule
