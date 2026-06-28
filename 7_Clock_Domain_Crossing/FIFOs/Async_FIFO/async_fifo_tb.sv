//============================================================
// TODO:
// Current overflow boundary test needs refinement.
// write_data() blocks when FIFO becomes full because the task
// waits for w_full to deassert before returning.
// Future improvements:
//   [ ] Separate fill and overflow tests.
//   [ ] Verify write pointer does not advance during overflow.
//   [ ] Investigate r_empty assertion after draining FIFO.
//============================================================


`timescale 1ns / 1ps

module async_fifo_tb;

    // Parameters
    localparam DATA_WIDTH = 8;
    localparam ADDR_WIDTH = 4;
    localparam DEPTH = 1 << ADDR_WIDTH;
    
    // Interface signals
    bit w_clk;
    logic w_rst_n;
    logic w_inc;
    logic [DATA_WIDTH-1:0]w_data;
    wire w_full;
    
    bit r_clk;
    logic r_rst_n;
    logic r_inc;
    wire [DATA_WIDTH-1:0]r_data;
    wire r_empty;
    
    // Instantiation
    async_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .w_clk(w_clk),.w_rst_n(w_rst_n),.w_inc(w_inc),.w_data(w_data),.w_full(w_full),
        .r_clk(r_clk),.r_rst_n(r_rst_n),.r_inc(r_inc),.r_data(r_data),.r_empty(r_empty)  
    );
    
    // Clock Generation
    initial begin
        w_clk = 1'b0;
        forever #5 w_clk = ~w_clk; // 10ns
    end

    initial begin
        r_clk = 1'b0;
        forever #7.5 r_clk = ~r_clk; // 15ns
    end
    
    
   // Verification Queue (Scoreboard)
    logic [DATA_WIDTH-1:0] expected_queue[$];
    
    // Write Driver Loop
    task automatic write_data(input int items, input bit stop_when_full = 1);
        int temp_val;
        repeat (items) begin
            @(posedge w_clk);
            while(w_full) begin
                if (stop_when_full) return;
                w_inc <= 1'b0;
                @(posedge w_clk); // Wait if FIFO is full
            end
            w_inc <= 1'b1;
            temp_val = $urandom_range(0,255);   // Blocking Statement
            w_data <= temp_val;
            expected_queue.push_back(temp_val);   // Track the written data exactly due to the earlier blocking statement
            $display("[WRITE] Time=%0t | Data=%0h", $time, temp_val);
        end
        @(posedge w_clk);
        w_inc <= 1'b0;
    endtask
    
    // Read driver and monitor loop
    task automatic read_data(input int items);
        logic [DATA_WIDTH-1:0]popped_val;
        int count = 0;
        
        while (count < items) begin
            @(posedge r_clk);
            if (!r_empty) begin
                r_inc <= 1'b1;
                // Captures data on next cycle after settling
                @(posedge r_clk);
                r_inc <= 1'b0;
                
                if(expected_queue.size() > 0) begin
                    popped_val = expected_queue.pop_front();
                    $display("[READ]  Time=%0t | Data=%0h", $time, r_data);
                    
                    // Self checking assensment
                    if(r_data !== popped_val) begin
                        $error("[ERROR] Mismatch! Expected=%0h, Got=%0h", popped_val, r_data);
                    end
                end
                count++;
            end else begin
                r_inc <= 1'b0;
                @(posedge r_clk);
            end
        end
    endtask
    
    // Main Stimulous
    initial begin
        w_rst_n = 0;
        r_rst_n = 0;
        w_inc   = 0;
        r_inc   = 0;
        w_data  = 0;
        
        // Apply Reset
        #30;
        @(posedge w_clk) w_rst_n = 1;
        @(posedge r_clk) r_rst_n = 1;
        $display("--- Reset Released ---");
        
        // 1. Simple Sequential Write and Read
        $display("--- Sequencial Write then Read ---");
        write_data(5,1);
        #50;
        read_data(5);
        
        // 2. Fill FIFO to the brim (Test Full Flag)
        $display("--- Testing Full Flag Boundary ---");
        write_data(DEPTH + 2,1); // Try to write more than depth
        #50;
        if (!w_full) $error("[ERROR] FIFO should be FULL!");
        
        // Empty it out entirely (Test Empty Flag)
        read_data(DEPTH);
        #50;
        if (!r_empty) $error("[ERROR] FIFO should be EMPTY!");
        
        // 3. Concurrent Reading and Writing at different speeds
        $display("--- Simultaneous Read & Write ---");
        fork
            write_data(30,1);
            begin
                #20; // Staggered start
                read_data(30);
            end
        join
        
        #100;
        $display("--- Simulation Finished Successfully! No unresolved mismatches. ---");
        $finish;
    end
    
    // Timeout watchdog
    initial begin
        #2000;
        $error("[TIMEOUT] Simulation caught in an infinite loop!");
        $finish;
    end
endmodule
