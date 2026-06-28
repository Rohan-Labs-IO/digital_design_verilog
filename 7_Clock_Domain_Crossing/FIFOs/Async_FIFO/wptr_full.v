// Write Pinter and Full Logic
module wptr_full #(
    parameter ADDR_WIDTH = 4
    )(
    input w_clk,
    input w_rst_n,
    input w_inc,
    input [ADDR_WIDTH:0] wq2_r_ptr,
    output reg w_full,
    output [ADDR_WIDTH-1:0] w_addr,
    output reg [ADDR_WIDTH:0] w_ptr
    );
    
    reg [ADDR_WIDTH:0] w_bin;
    wire [ADDR_WIDTH:0] w_bin_next;
    wire [ADDR_WIDTH:0] w_gray_next;
    
    // Memory Address Generation
    assign w_addr = w_bin[ADDR_WIDTH-1:0];
    
    // Binary Pointer Increment 
    assign w_bin_next = w_bin + (w_inc & ~w_full);
    
    // Conversion of Binary to Gray Code
    assign w_gray_next = (w_bin_next >> 1) ^ w_bin_next;
    
    always @(posedge w_clk or negedge w_rst_n) begin
        if (!w_rst_n) begin
            w_bin <= 0;
            w_ptr <= 0;
        end else begin
            w_bin <= w_bin_next;
            w_ptr <= w_gray_next;
        end
    end
    
    // FIFO is full when MSB and MSB-1 are inverted, but the remaining bits match
    wire w_full_val = (w_gray_next == {~wq2_r_ptr[ADDR_WIDTH:ADDR_WIDTH-1], wq2_r_ptr[ADDR_WIDTH-2:0]});
    
    always @(posedge w_clk or negedge w_rst_n) begin
        if (!w_rst_n) w_full <= 1'b0;
        else w_full <= w_full_val;
    end
endmodule
