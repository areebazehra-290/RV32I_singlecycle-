`timescale 1ns/1ps
module top_tb;

reg clk;
reg reset;

top uut(.clk(clk), .reset(reset));

// Clock generation
always #5 clk = ~clk;   // 10ns clock = 100MHz

initial begin
    $display("------ 32 BIT PROCESSOR SIMULATION STARTED ------");

    clk = 0;
    reset = 1;

    // Hold reset for a few cycles
    #20;
    reset = 0;

    // Preload instruction memory manually
    // IMPORTANT: Change instruct_mem.IMemory to your memory name if different
    uut.instruct_mem.IMemory[0] = 32'h002082B3; // Example R-type add
    uut.instruct_mem.IMemory[1] = 32'h40310333; // Example sub
    uut.instruct_mem.IMemory[2] = 32'h00512023; // sw
    uut.instruct_mem.IMemory[3] = 32'h00012303; // lw
    uut.instruct_mem.IMemory[4] = 32'hFE208EE3; // beq
    // Add more instructions if needed

    // Run the CPU for some cycles
    repeat(40) begin
        #10;

        $display("PC=%h | Instr=%h | Rd1=%h | Rd2=%h | ALUres=%h | Mem=%h | WB=%h",
            uut.pc_top,
            uut.instruction_top,
            uut.Rd1_top,
            uut.Rd2_top,
            uut.address_top,  // ALU result output
            uut.Memdata_top,
            uut.WriteBack_top
        );
    end

    $display("------ SIMULATION FINISHED ------");
    $stop;
end

endmodule

