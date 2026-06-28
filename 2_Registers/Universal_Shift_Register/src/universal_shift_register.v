`timescale 1ns / 1ps

module universal_shift_register(
    input clk,
    input reset,
    input [1:0]select,
    input si_left,      // For right shifting
    input si_right,     // For left shifting
    
    input [3:0] pi,
    
    output so,
    output [3:0] po
    );
    
    reg [3:0]q;
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            q <= 4'b0000;
        end else begin
            case (select) 
                2'b00: q <= q;      //HOLD  
                2'b01: q <= {si_left,q[3:1]};// RIGHT SHIFT
                2'b10: q <= {q[2:0],si_right};// LEFT SHIFT
                2'b11: q <= pi;// PARALLEL INPUT LOADING
            endcase
        end
    end
    
    assign so = (select == 2'b01) ? q[0] :   // Shift Right
            (select == 2'b10) ? q[3] :   // Shift Left
            1'b0;   // Output 0 when not shifting
    assign po = q;
endmodule