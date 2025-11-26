module top(clk, reset);
 input clk, reset;

 wire [31:0] pc_top, instruction_top, Rd1_top, Rd2_top, ImmExt_top, mux1_top, sum_out_top, NextPC_top, PCin_top, address_top, Memdata_top, WriteBack_top;
 wire RegWrite_top, ALUSrc_top, zero_top, branch_top, sel2_top, MemtoReg_top, MemWrite_top, MemRead_top;
 wire [1:0] ALUOp_top;
 wire [3:0] Control_top;
 
 // Program Counter
 program_counter pc(.clk(clk), .reset(reset), .pc_in(PCin_top), .pc_out(pc_top));

 // PC Adder
 PCplus4 PC_Adder(.start_pc(pc_top), .out_pc(NextPC_top));

 // Instruction Memory
 instruct_mem instruct_mem(.clk(clk), .reset(reset), .read_address(pc_top), .instruction_out(instruction_top));

 // Register File
 reg_file Reg_File(.clk(clk), .reset(reset), .RegWrite(RegWrite_top), .Rs1(instruction_top[19:15]), .Rs2(instruction_top[24:20]), .Rd(instruction_top[11:7]), .Write_data(WriteBack_top), .read_data1(Rd1_top), .read_data2(Rd2_top));

 // Immediate Generator
 imm_gen immgen(.Opcode(instruction_top[6:0]), .Instruction(instruction_top), .ImmExt(ImmExt_top));

 // Control Unit
  control_unit Control_Unit(.instruction(instruction_top[6:0]), .Branch(branch_top), .MemRead(MemRead_top), .MemtoReg(MemtoReg_top), .ALUOp(ALUOp_top), .MemWrite(MemWrite_top), .ALUSrc(ALUSrc_top), .RegWrite(RegWrite_top));
 
 // ALU Control
 ALU_Control ALU_Control(.ALUOp(ALUOp_top), .fun7(instruction_top[30]), .fun3(instruction_top[14:12]), .Control_out(Control_top));
 
 // ALU
 ALU_unit ALU_A(.A(Rd1_top), .B(mux1_top), .Control_in(Control_top), .ALU_Result(address_top), .zero(zero_top));
 
 // ALU Mux 1
 mux_1 ALU_mux(.sel1(ALUSrc_top), .A1(Rd2_top), .B1(ImmExt_top), .mux1_out(mux1_top));

 // Adder
 adder Adder_in(.in_1(pc_top), .in_2(ImmExt_top), .Sum_out(Sum_out_top));

 // AND Gate
 And_logic AND(.branch(branch_top), .zero(zero_top), .and_out(sel2_top));

 // Mux 2
 mux_2 Adder_mux(.sel2(sel2_top), .A2(NextPC_top), .B2(Sum_out_top), .mux2_out(PCin_top));

 // Data Memory
 data_memory data_Mem(.clk(clk), .reset(reset), .MemWrite(MemWrite_top), .MemRead(MemRead_top), .read_address(address_top), .Write_data(Rd2_top), .MemData_out(Memdata_top));

 //mux 3
 mux_3 Memory_mux(.sel3(MemtoReg_top), .A3(address_top), .B3(Memdata_top), .mux3_out(WriteBack_top));

 endmodule 