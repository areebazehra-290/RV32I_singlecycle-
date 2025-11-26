module instruct_mem(clk, reset, read_address, instruction_out);

    input clk, reset;
    input  [31:0] read_address;
    output reg [31:0] instruction_out;

    reg [31:0] IMemory [0:63];

    initial begin
        
        // Program: simple arithmetic + load + store + loop
        
        // PC = 0 → IMemory[0]
        IMemory[0] = 32'h00500113;  // addi x2, x0, 5     (x2 = 5)
        IMemory[1] = 32'h00A00193;  // addi x3, x0, 10    (x3 = 10)
        IMemory[2] = 32'h00310233;  // add  x4, x2, x3    (x4 = x2 + x3 = 15)
        IMemory[3] = 32'h00412023;  // sw   x4, 0(x2)     store x4 → MEM[x2]
        IMemory[4] = 32'h00012303;  // lw   x6, 0(x2)     load x6 ← MEM[x2]
        IMemory[5] = 32'h0061A463;  // beq  x3, x6, +8    if x3==x6 skip ahead
        IMemory[6] = 32'h00120213;  // addi x4, x4, 1     (increment x4)
        IMemory[7] = 32'hFE0006E3;  // beq  x0, x0, -8    (ALWAYS branch → loop)

        IMemory[8] = 32'h00000013;  // NOP
        IMemory[9] = 32'h00000013;  // NOP
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            instruction_out <= 32'b0;
        else
            instruction_out <= IMemory[read_address >> 2];
    end

endmodule
