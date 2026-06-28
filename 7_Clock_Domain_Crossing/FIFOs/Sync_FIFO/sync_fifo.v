module sync_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4,
    parameter DEPTH = 16
)(
    input clk,
    input rst_n,                        // Active Low reset
    input wr_en,                        // Enables writing
    input [DATA_WIDTH-1:0]wr_data,      // Data to be written
    input rd_en,                        // Enables reading
    output reg [DATA_WIDTH-1:0]rd_data,   // Data that is read
    // Flags
    output full,
    output empty
    );
    
    // Memory Array
    reg [DATA_WIDTH-1:0] fifo_mem [0:DEPTH-1];
    
    // Pointers (we need 1 bit more than ADDR_WIDTH to ensure the flags work properly)
    reg [ADDR_WIDTH:0] wr_ptr;
    reg [ADDR_WIDTH:0] rd_ptr;
    
    
    // Read Logic
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rd_data <= 0;
            rd_ptr <= 0;
        end else if (rd_en && !empty) begin
            rd_data <= fifo_mem[rd_ptr[ADDR_WIDTH-1:0]];
            rd_ptr <= rd_ptr + 1;
        end
    end
    
    // Write Logic
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wr_ptr <= 0;
        end else if (wr_en && !full) begin
            fifo_mem[wr_ptr[ADDR_WIDTH-1:0]] <= wr_data;
            wr_ptr <= wr_ptr + 1;
        end
    end
    
    // Status Flag Logic
    assign empty = (rd_ptr == wr_ptr);  // Empty when both pointers are actually equal
    
    // Full when MSB is not equal but LSB are equal
    assign full = (wr_ptr[ADDR_WIDTH] != rd_ptr[ADDR_WIDTH]) &&
                  (wr_ptr[ADDR_WIDTH-1:0] == rd_ptr[ADDR_WIDTH-1:0]);
endmodule
