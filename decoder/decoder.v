//---------------------------------------------------------------
// MODULE : DECODER(2x4)
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              decoder using data flow 
//---------------------------------------------------------------

module decoder(input A,input B,output Y1,output Y2,output Y3,output Y4);


assign Y1 = ~A & ~B;
assign Y2 = ~A & B;
assign Y3 = A & ~B;
assign Y4 = A & B;

endmodule


module tb;
reg A,B;
wire Y1,Y2,Y3,Y4;

decoder dut(.A(A),.B(B),.Y1(Y1),.Y2(Y2),.Y3(Y3),.Y4(Y4));
initial
begin

$dumpfile("decoder.vcd");
$dumpvars(0,tb);

$monitor("TIME : %0t | A = %b | B = %b | Y1 = %b | Y2 = %b | Y3 = %b | Y4 = %b |",$time,A,B,Y1,Y2,Y3,Y4);
#10 A=1'b0;B=1'b0;
#10 A=1'b0;B=1'b1;
#10 A=1'b1;B=1'b0;
#10 A=1'b1;B=1'b1;
#10 $finish;

end

endmodule
