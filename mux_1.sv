//mux 01   
module mux_1(sel1, A1, B1, mux1_out);
    input sel1;
    input [31:0] A1, B1;
    output [31:0] mux1_out;

    assign mux1_out = (sel1 == 1'b0) ? A1 : B1;
endmodule
