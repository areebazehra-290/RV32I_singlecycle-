module reg_file_TB;

    reg clk;
    reg reset;
    reg RegWrite;
    reg [4:0] Rs1, Rs2, Rd;
    reg [31:0] Write_data;
    wire [31:0] read_data1, read_data2;

    reg_file uut (clk, reset, RegWrite, Rs1, Rs2, Rd, Write_data, read_data1, read_data2);

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        RegWrite = 0;
        Rs1 = 0;
        Rs2 = 0;
        Rd = 0;
        Write_data = 0;

        #10 reset = 0;

        // Write value into register 5
        Rd = 5;
        Write_data = 32'h11111111;
        RegWrite = 1;
        #10;

        RegWrite = 0;

        // Read register 5
        Rs1 = 5;
        Rs2 = 5;
        #10;

        // Write value into register 10
        Rd = 10;
        Write_data = 32'h22222222;
        RegWrite = 1;
        #10;

        RegWrite = 0;

        // Read register 10
        Rs1 = 10;
        Rs2 = 10;
        #10;

        $stop;
    end

endmodule
