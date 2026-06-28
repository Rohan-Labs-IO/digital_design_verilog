module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4  // Depth = 2^ADDR_WIDTH
    )(
    // Write Domain
    input w_clk,                            // Clock for Write Domain
    input w_rst_n,                          // Active Low Reset for Write Domain
    input w_inc,                            // Write Increment[Enable]
    input [DATA_WIDTH-1:0]w_data,           // Write Sata
    output w_full,                          // Full Flag of FIFO
    
    // Read Domain
    input r_clk,                            // Clock for Read Domain
    input r_rst_n,                          // Active Low Reset for Read Domain
    input r_inc,                            // Read Increment[Enable]
    output [DATA_WIDTH-1:0]r_data,          // Read Sata
    output r_empty                          // Empty Flag of FIFO
    );
    
    wire [ADDR_WIDTH-1:0] w_addr, r_addr;
    wire [ADDR_WIDTH:0] w_ptr, r_ptr;
    wire [ADDR_WIDTH:0] wq2_r_ptr, rq2_w_ptr;
    
    // RAM Memory Array
    fifo_mem #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
    ) u_mem (
    .w_clk(w_clk),
    .w_clk_en(w_inc && !w_full),
    .w_addr(w_addr),
    .r_addr(r_addr),
    .w_data(w_data),
    .r_data(r_data)
    );
    
    // Read Domain Logic
    rptr_empty #(ADDR_WIDTH) u_rptr_empty(
    .r_clk(r_clk),
    .r_rst_n(r_rst_n),
    .r_inc(r_inc),
    .rq2_w_ptr(rq2_w_ptr),     // Synchronised write pointer
    .r_empty(r_empty),
    .r_addr(r_addr),
    .r_ptr(r_ptr)
    );
    
    // Write Domain Logic
    wptr_full #(ADDR_WIDTH) u_wptr_full (
    .w_clk(w_clk),
    .w_rst_n(w_rst_n),
    .w_inc(w_inc),
    .wq2_r_ptr(wq2_r_ptr),
    .w_full(w_full),
    .w_addr(w_addr),
    .w_ptr(w_ptr)
    );
    
    
    // Synchronise Write Pointer in Read Clock Domain
    sync_ptr#(ADDR_WIDTH) u_sync_w2r (
    .clk(r_clk),
    .rst_n(r_rst_n),
    .ptr_in(w_ptr),
    .ptr_out(rq2_w_ptr)
    );
    
    // Synchronise Read Pointer in Write Clock Domain
    sync_ptr#(ADDR_WIDTH) u_sync_r2w (
    .clk(w_clk),
    .rst_n(w_rst_n),
    .ptr_in(r_ptr),
    .ptr_out(wq2_r_ptr)
    );
endmodule
