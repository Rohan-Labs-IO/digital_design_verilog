module sync_ptr #(
    parameter ADDR_WIDTH = 4
    )(
    input clk,
    input rst_n,
    input [ADDR_WIDTH:0] ptr_in,
    output reg [ADDR_WIDTH:0] ptr_out
    );
    
    reg [ADDR_WIDTH:0] sync_reg;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sync_reg <= 0;
            ptr_out <= 0;
        end else begin
            sync_reg <= ptr_in;
            ptr_out <= sync_reg;
        end
    end
endmodule
