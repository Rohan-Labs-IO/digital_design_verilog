`timescale 1ns / 1ps

module SISO(
    input clk,
    input reset,
    input si,       // data comes in here, one bit at a time
    output so       // and pops out here after 4 clocks
    );
    
    // this is our 4-bit "pipe" 
    reg [3:0] q;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000; // clear everything if reset is hit
        end else begin
            // shift everything left and shove the new 'si' into the empty spot
            // q[3] gets removed, q[0] takes the new bit
            q <= {q[2:0], si};
        end
    end

    // the output is just whatever made it to the end of the line (bit 3)
    assign so = q[3];

endmodule