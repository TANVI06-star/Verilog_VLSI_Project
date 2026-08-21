//---------------------------------------------------------------
// MODULE : ALU
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//               one bit alu.
//---------------------------------------------------------------


module alu(input A,input B,input [2:0]operator,output reg Y);



always @(*)
begin
case(operator)
3'b000 : Y = A + B;
3'b001 : Y = A - B;
3'b010 : Y = A * B;
3'b011 : Y = A / B;
3'b100 : Y = A % B;
default : $display("INVALID OPERATION");

endcase
end

endmodule


module tb;
reg A,B;
reg [2:0]op;
wire Y;
integer i;

alu dut(.A(A),.B(B),.operator(op),.Y(Y));

initial 
begin
$dumpfile("alu.vcd");
$dumpvars(0,tb);

$monitor("TIME = %t | A = %b | B = %b | op  = %b | Y = %b |",$time,A,B,op,Y);

A=1'b1;B=1'b1; op = 3'b000;

for(i = 0;i <= 6; i = i + 1)
begin 
#10 op = op + 1;
end
#10 $finish;
end
endmodule