`timescale 1ns / 1ps

module pulse_synchronizer(
    // Source Clock Domain
    input clk_src,
    input rst_n_src,            // Active Low Reset For Source Domain
    input pulse_in,             // Input Pulse
    
    // Destination Clock Domain
    input clk_dst,
    input rst_n_dst,            // Active Low Reset For Source Domain
    output pulse_out            // Output Pulse
    );
    
    // 1. Pulse to Toggle Circuit (for source clock domain)
    reg src_pulse_reg;
    
    always @(posedge clk_src or negedge rst_n_src) begin
        if (!rst_n_src) src_pulse_reg <= 1'b0;
        else if (pulse_in) src_pulse_reg <= ~src_pulse_reg; // Toggles when pulse comes
    end
    
    // 2. 2FF Synchroniser
    reg dst_sync_ff1, dst_sync_ff2;
    
    always @(posedge clk_dst or negedge rst_n_dst) begin
        if (!rst_n_dst) begin
            dst_sync_ff1 <= 0;
            dst_sync_ff2 <= 0;
        end else begin
            dst_sync_ff1 <= src_pulse_reg;
            dst_sync_ff2 <= dst_sync_ff1;
        end
    end
    
    // 3. Toggle to Pulse Circuit (for destination clock domain)
    reg dst_sync_ff3;
    
    always @(posedge clk_dst or negedge rst_n_dst) begin
        if (!rst_n_dst) dst_sync_ff3 <= 1'b0;
        else dst_sync_ff3 <= dst_sync_ff2;      // Delaying by a clock cycle
    end 
    
    // Xor operation is used to keep the output producing a pulse as well
    assign pulse_out = dst_sync_ff3 ^ dst_sync_ff2;
endmodule
