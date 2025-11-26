// program counter 
module program_counter(pc_out,clk,reset,pc_in);
output reg[31:0] pc_out;
input clk,reset;
input [31:0] pc_in;
always @(posedge clk or posedge reset)
begin 
if(reset)
	pc_out <= 32'b00;
else
	pc_out <= pc_in;
end
endmodule 

// pc + 4 adder module 
module PCplus4(start_pc,out_pc);
input [31:0] start_pc;
output [31:0] out_pc;
assign out_pc = 4 + start_pc;
endmodule 