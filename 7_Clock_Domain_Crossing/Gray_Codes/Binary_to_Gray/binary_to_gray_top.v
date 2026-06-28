// 4-bit default width, but can be changed for larger data buses
module binary_to_gray_top #(
    parameter WIDTH = 4
    )(
    input  [WIDTH-1:0] inp_data,
    output [WIDTH-1:0] op_data
    );
    
    // Quick hardware trick: XOR the binary data with itself shifted right by 1 bit
    assign op_data = inp_data ^ (inp_data >> 1);
    
    /* The long way (Alternative loop method):
    
    integer i;
    always @(*) begin
        // The highest bit (MSB) always stays the same
        op_data[WIDTH-1] = inp_data[WIDTH-1]; 
        
        // Loop through the rest of the bits and XOR each with the neighbor to its left
        for(i = 0; i < WIDTH-1; i = i + 1) begin
            op_data[i] = inp_data[i] ^ inp_data[i+1];
        end
    end
    */
endmodule