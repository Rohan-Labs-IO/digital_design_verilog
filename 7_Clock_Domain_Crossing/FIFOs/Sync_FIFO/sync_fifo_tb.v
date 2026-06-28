`timescale 1ns / 1ps

module sync_fifo_tb;

    // PARAMETERS OF FIFO THAT WE DESIRE
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;
    parameter DEPTH = 16;
    
    
    
    reg clk;
    reg rst_n;                        // Active Low reset
    reg wr_en;                        // Enables writing
    reg [DATA_WIDTH-1:0]wr_data;      // Data to be written
    reg rd_en;                        // Enables reading
    wire [DATA_WIDTH-1:0]rd_data;   // Data that is read
    wire full;
    wire empty;
    
    sync_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .DEPTH(DEPTH)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .wr_data(wr_data),
        .rd_en(rd_en),
        .rd_data(rd_data),
        .full(full),
        .empty(empty)
    );
    
    integer i;
    
    // Clk generation
    always #10 clk = ~clk;
    
    initial begin
        clk = 0;
        rst_n = 0; // Reset is enabled
        wr_en = 0;
        wr_data = 0;
        rd_en = 0;
        
        #40; rst_n = 1; // Reset is disabled
        $display("Reset released. Actual sequence testing begins.");
        
        // Initial Empty flag check
        if(empty && !full) $display("FIFO is completely empty at the begining");
        else $display("ERROR!!! FIFO is not initially empty");
        
        // Filling the FIFO  to the max limit
        $display("FIFO is beign filled");
        for (i = 0; i < DEPTH; i = i + 1) begin
            @(negedge clk); // Drives the input at falling to avoid race condition
            wr_en = 1;
            wr_data = 8'hA0 + 1;   
        end
        
        // Turning off writing
        @(negedge clk);
        wr_en = 0;
        wr_data = 0;
        
        // Initial Full flag check
        #5;
        if(!empty && full) $display("FIFO is correctly full");
        else $display("ERROR!!! FIFO is not correctly filled");
        
        // Overflow Protection Test
        $display("[TB] Attempting an illegal write to a full FIFO...");
        @(negedge clk);
        wr_en   = 1;
        wr_data = 8'hFF; // This shouldn't overwrite anything
        
        @(negedge clk);
        wr_en = 0;

        // Read everything back out
        $display("[TB] Emptying FIFO...");
        for (i = 0; i < DEPTH; i = i + 1) begin
            @(negedge clk);
            rd_en = 1;
            
            // Monitor data on the next rising edge
            @(posedge clk);
            #1; // Brief delay to let output stabilize
            $display("[READ] Slot %0d: Expected = %h, Got = %h", i, (8'hA0 + i), rd_data);
        end

        // Turn off read enable
        @(negedge clk);
        rd_en = 0;

        // Check if empty flag raised again
        #5;
        if (empty && !full)
            $display("[SUCCESS] FIFO is back to EMPTY.");
        else
            $display("[ERROR] FIFO failed to return to EMPTY.");

        // End Simulation
        #100;
        $display("[TB] Simulation completed successfully!");
        $finish;
    end
endmodule
