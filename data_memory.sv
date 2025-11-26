// Data Memory
module data_memory (
    input        clk,
    input        reset,
    input        MemWrite,
    input        MemRead,
    input  [31:0] read_address,
    input  [31:0] Write_data,
    output [31:0] MemData_out
);

    integer k;
    reg [31:0] d_Memory [63:0];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (k = 0; k < 64; k = k + 1) begin
                d_Memory[k] <= 32'b0;
            end
        end else if (MemWrite) begin
            d_Memory[read_address] <= Write_data;
        end
    end

    assign MemData_out = (MemRead) ? d_Memory[read_address] : 32'b0;

endmodule
