// Immediate Generator
 module imm_gen(Opcode, Instruction, ImmExt);
 
 input [6:0] Opcode;
 input [31:0] Instruction;
 output reg [31:0] ImmExt;
 
 always @(*)
 begin
     case (Opcode)
         7'b0000011 : ImmExt <= {{20{Instruction[31]}}, Instruction[31:20]}; // Load (I-type)
         7'b0100011 : ImmExt <= {{20{Instruction[31]}}, Instruction[31:25], Instruction[11:7]}; // Store (S-type)
         7'b1100011 : ImmExt <= {{19{Instruction[31]}}, Instruction[31], Instruction[30:25], Instruction[11:8], 1'b0}; // Branch (B-type)
 
     endcase
 end
 endmodule