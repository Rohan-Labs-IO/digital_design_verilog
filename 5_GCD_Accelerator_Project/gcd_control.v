`timescale 1ns / 1ps

module gcd_control(
    input clk,
    input start, 
    input reset,
    input is_equal,
    input is_greater,
    
    output reg write_en,  // Write enable for register
    output reg [2:0]r_add1,   // Read register 1
    output reg [2:0]r_add2,   // Read register 2
    output reg [2:0]w_add,    // Write the value in regiser
    output reg [1:0]select,   // Control Data input sources
    output reg done      // shows the status of flag
    );
    
    
    // STATE LOCAL ENCODING
    localparam S_IDLE = 3'b000,
               S_LOAD_A = 3'b001,
               S_LOAD_B = 3'b010,
               S_CHECK = 3'b011,
               S_SUB_A = 3'b100,
               S_SUB_B = 3'b101,
               S_DONE = 3'b110;
               
    reg [2:0] current_state, next_state;
    
    localparam REG_A = 3'd1, // Stores the value of A
               REG_B = 3'd2; // Stores the value of B
               
               
    // 1. STATE REGISTER 
    always @(posedge clk or posedge reset) begin
        if (reset) current_state <= S_IDLE;
        else current_state <= next_state;
    end
    
    // 2. NEXT STATE LOGIC
    always @(*) begin
        case (current_state)
            S_IDLE: next_state = start? S_LOAD_A : S_IDLE;
            S_LOAD_A: next_state = S_LOAD_B;
            S_LOAD_B: next_state = S_CHECK;
            S_CHECK: begin
                if (is_equal) next_state = S_DONE;
                else if (is_greater) next_state = S_SUB_A; // A > B
                else next_state = S_SUB_B; // A < B
            end            
            S_SUB_A: next_state = S_CHECK;
            S_SUB_B: next_state = S_CHECK;
            S_DONE: next_state = start? S_DONE: S_IDLE; // Wait for start to drop 
            default next_state = S_IDLE;
        endcase
    end
    
    // 3. OUTPUT LOGIC
    always @(*) begin
        // default values
        write_en = 0;
        r_add1 = REG_A;
        r_add2 = REG_B;
        w_add = REG_A;
        select = 2'b00;
        done = 0;
        
        case (current_state)
            S_LOAD_A: begin
                write_en = 1;
                w_add = REG_A;
                select = 2'b01; // Selects REG_A to write
            end   
            S_LOAD_B: begin
                write_en = 1;
                w_add = REG_B;
                select = 2'b10;
            end          
            S_CHECK: write_en = 0;         
            S_SUB_A: begin // A - B
                w_add = REG_A;
                write_en = 1;
                select = 2'b00; // Take the comparator output
            end            
            S_SUB_B: begin
                w_add = REG_B;
                write_en = 1;
                select = 2'b00; // Take the comparator output
            end             
            S_DONE: begin
                done = 1;
            end
        endcase
    end
endmodule