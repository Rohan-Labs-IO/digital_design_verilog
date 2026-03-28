`timescale 1ns / 1ps

module testbench;
    // Input
    reg [3:0]a;
    reg [3:0]b;
    reg [3:0]opcode;
    // Output
    wire [7:0]result;
    wire c,v,z,s;
    
    main_source uut(
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .c(c),
        .v(v),
        .z(z),
        .s(s)
    );
    
    // Printing task
    task display_output;
        begin
            $display("Time=%0t | opcode=%0d | A=%b | B=%b | Result=%b | C=%b V=%b Z=%b S=%b",
                     $time, opcode, a, b, result, c, v, z, s);
        end
    endtask
    
    initial begin
        $display("------------------------ALU TEST START ---------------------------");
        
        // ----------LOGICAL OPERATIONS-------------------//
        a = 4'b1100; b = 4'b0110;
        
        opcode = 4'd0; #10; display_output();     // OR
        opcode = 4'd1; #10; display_output();     // AND
        opcode = 4'd2; #10; display_output();     // XOR
        opcode = 4'd3; #10; display_output();     // NOR
        
        // ---------ADDITION-------------//
        a = 4'b0101; b = 4'b0011; opcode = 4'd4; #10; display_output();
        
        // ---------OVERFLOW-------------//
        a = 4'b1101; b = 4'b0011; opcode = 4'd4; #10; display_output();
        
        // ---------SUBTRACTION-------------//
        a = 4'b1000; b = 4'b0001; opcode = 4'd5; #10; display_output();
        
        // ---------NEGATIVE RESULT-------------//
        a = 4'b0101; b = 4'b1011; opcode = 4'd5; #10; display_output();
        
        // ---------MULTIPLICATION-------------//
        a = 4'b0101; b = 4'b0011; opcode = 4'd6; #10; display_output();
        
        // ---------MAX CASE OF MULTIPLICATION-------------//
        a = 4'b1111; b = 4'b1111; opcode = 4'd6; #10; display_output();
        
        // ---------COMPARATOR-------------//
        a = 4'b0101; b = 4'b0011; opcode = 4'd7; #10; display_output(); // A >> B
        a = 4'b0001; b = 4'b0011; opcode = 4'd7; #10; display_output(); // A << B
        a = 4'b0101; b = 4'b0101; opcode = 4'd7; #10; display_output(); // A == B
        
        // ------------- RANDOM TEST CASES ---------------//
        repeat (5) begin
            a = $random % 16;
            b = $random % 16;
            opcode = $random % 8;
            #10; display_output();
        end
        
        
        $display("------------------------ALU TEST END ---------------------------");
        $finish;
        
    end
endmodule
