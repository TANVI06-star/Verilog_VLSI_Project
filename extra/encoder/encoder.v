//---------------------------------------------------------------
// MODULE : ENCODER(4x2)
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              Encoder using data flow 
//---------------------------------------------------------------



module encoder(input Y1,input Y2,input Y3,input Y4,output A,output B);

assign A = Y2 + Y1;
assign B = Y1 + Y3;
endmodule

module tb;

reg Y1,Y2,Y3,Y4;
wire A,B;

encoder dut(.Y1(Y1),.Y2(Y2),.Y3(Y3),.Y4(Y4),.A(A),.B(B));

initial
begin
$dumpfile("encoder.vcd");
$dumpvars(0,tb);

$monitor("TIME : %0t |  Y1 = %b | Y2 = %b | Y3 = %b | Y4 = %b | A = %b | B = %b |",$time,Y1,Y2,Y3,Y4,A,B);
#10 Y1=1'b0;Y2=1'b0;Y3=1'b0;Y4=1'b1;
#10 Y1=1'b0;Y2=1'b0;Y3=1'b1;Y4=1'b0;
#10 Y1=1'b0;Y2=1'b1;Y3=1'b0;Y4=1'b0;
#10 Y1=1'b1;Y2=1'b0;Y3=1'b0;Y4=1'b0;
#10 $finish;

end
endmodule