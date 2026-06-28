module fifo_mem#(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
    )(
    input w_clk,
    input w_clk_en,
    input [ADDR_WIDTH-1:0] w_addr,
    input [ADDR_WIDTH-1:0] r_addr,
    input [DATA_WIDTH-1:0] w_data,
    output [DATA_WIDTH-1:0] r_data
    );
    
    localparam DEPTH = 1 << ADDR_WIDTH;
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    
    assign r_data = mem[r_addr];
    
    always @(posedge w_clk) begin
        if (w_clk_en) mem[w_addr] <= w_data;
    end
endmodule
