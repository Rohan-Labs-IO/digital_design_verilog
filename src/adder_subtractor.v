`timescale 1ns / 1ps

module adder_subtractor(
    input [3:0] a,  // 4bit Input a
    input [3:0] b,  // 4 bit Input b
    input mode,     // 0 = addition, 1 = subtraction
    output [3:0]y,  // 4 bit result
    output c,       // Carry Out (Unsigned overflow)
    output v,       // Overflow (Signed overflow)
    output z,       // Zero flag
    output s        // Sign flag (Negative)
    );
    
    // It flips the value of all bits of b if the mode = 1, using XOR logic
    wire [3:0] b_mod = b ^ {4{mode}};
    wire [4:0] full_res;
    
    // The final result is calculated as, result = a + modified b + mode
    assign full_res = a + b_mod + mode;
    assign y = full_res[3:0];
    
    // Carry flag
    assign c = full_res[4];
    
    // Sign flag
    assign s = y[3];
    
    // Zero flag
    assign z = (y == 4'b0000);
    
    // Overflow flag (V): True if (Pos + Pos = Neg) or (Neg + Neg = Pos)
    assign v = (a[3] == b_mod[3]) && (y[3] != a[3]);
endmodule
