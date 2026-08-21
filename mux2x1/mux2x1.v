//---------------------------------------------------------------
// MODULE : 2X1 MULTIPLEXER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              Multiplex using design flow (RTL Modelling)
//---------------------------------------------------------------


module mux2x1(input S,input I1,input I2,output Y);
assign Y = (S == 0) ? I1 : I2;
endmodule



module tb;

wire Y;
reg s,I1,I2;

mux2x1 dut(.S(s),.I1(I1),.I2(I2),.Y(Y));

initial 
begin
$dumpfile("mux2x1.vcd");
$dumpvars(0,tb);
$monitor("TIME : %0t | S = %b | I1 = %b | I2 = %b | Y = %b",$time,s,I1,I2,Y);

#10 s=1'b1;I1=1'b0;I2=1'b1;
#10 s=1'b0;I1=1'b1;I2=1'b1;
#10 s=1'b1;I1=1'b1;I2=1'b0;
#10 s=1'b0;I1=1'b1;I2=1'b0;
#10 s=1'b1;I1=1'b1;I2=1'b0;
#10 $finish;

end

endmodule