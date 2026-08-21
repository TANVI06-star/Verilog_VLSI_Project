//---------------------------------------------------------------
// MODULE : 4X1 MULTIPLEXER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              4x1 Multiplexer using design flow (RTL Modelling)
//---------------------------------------------------------------

module mux2x1(input S,input [1:0]I,output Y);
assign Y = (S==0) ? (I[0]) : (I[1]);
endmodule


module mux4x1(input S1,input S2,input [3:0]I,output Y);

wire y1,y2;
wire [1:0]i;

mux2x1 U1(.S(S2),.I(I[3:2]),.Y(y1));
mux2x1 U2(.S(S2),.I(I[1:0]),.Y(y2));
assign i[1] = y1;
assign i[0] = y2;
mux2x1 U3(.S(S1),.I(i),.Y(Y));

endmodule



module tb;

reg S1,S2;
reg [3:0]i;
wire Y;

mux4x1 dut(.S1(S1),.S2(S2),.I(i),.Y(Y));

initial
begin
$dumpfile("mux_4x1.vcd");
$dumpvars(0,tb);
$monitor("TIME = %0t | S1 = %b | s2 = %b | I = %b | Y = %b",$time,S1,S2,i,Y);

i=4'b1010;S1=1'b0;S2=1'b1;
#10 i=4'b1010;S1=1'b1;S2=1'b0;
#10 i=4'b1010;S1=1'b1;S2=1'b1;
#10 $finish;

end

endmodule