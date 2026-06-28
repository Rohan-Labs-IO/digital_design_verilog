// Read Pointer and Empty Logic
module rptr_empty #(
    parameter ADDR_WIDTH = 4
    )(
    input r_clk,
    input r_rst_n,
    input r_inc,
    input [ADDR_WIDTH:0] rq2_w_ptr,     // Synchronised write pointer
    output reg r_empty,
    output [ADDR_WIDTH-1:0] r_addr,
    output reg [ADDR_WIDTH:0] r_ptr
    );
    
    reg [ADDR_WIDTH:0] r_bin;
    wire [ADDR_WIDTH:0] r_bin_next;
    wire [ADDR_WIDTH:0] r_gray_next;
    
    // Memory Address Generation
    assign r_addr = r_bin[ADDR_WIDTH-1:0];
    
    // Binary Pointer Increment
    assign r_bin_next = r_bin + (r_inc & ~r_empty);
    
    // Convertion of Binary to Gray Code
    assign r_gray_next = (r_bin_next >> 1) ^ r_bin_next;
    
    always @(posedge r_clk or negedge r_rst_n) begin
        if(!r_rst_n) begin
            r_bin <= 0;
            r_ptr <= 0;
        end else begin
            r_bin <= r_bin_next;
            r_ptr <= r_gray_next;
        end
    end
    
    // FIFO will be empty when next read pointer matches the write pointer
    wire r_empty_val = (r_gray_next == rq2_w_ptr);
    
    always @(posedge r_clk or negedge r_rst_n) begin
        if (!r_rst_n) r_empty <= 1'b1;
        else r_empty <= r_empty_val;
    end
endmodule
