//---------------------------------------------------------------
// MODULE : 4X1 MULTIPLEXER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              4x1 Multiplexer using data flow
//---------------------------------------------------------------


module mux4x1(input s1,input s2,input [3:0]i,output Y);
assign Y = (s1==0) ? ( (s2==0) ? (i[0]) : (i[1])) : ((s2==1) ? (i[3]) : (i[2]));

endmodule

module tb;

reg s1,s2;
reg [3:0]I;
wire Y;

mux4x1 dut(.s1(s1),.s2(s2),.i(I),.Y(Y));

initial
begin
$dumpfile("mux4x1.vcd");
$dumpvars(0,tb);

$monitor("TIME = %0t | S1 = %b | s2 = %b | I = %b | Y = %b",$time,s1,s2,I,Y);

I=4'b1010;s1=1'b0;s2=1'b1;
#10 I=4'b1010;s1=1'b1;s2=1'b0;
#10 I=4'b1010;s1=1'b1;s2=1'b1;
#10 $finish;

end

endmodule