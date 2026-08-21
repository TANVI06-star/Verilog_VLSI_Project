//---------------------------------------------------------------
// MODULE : ALU
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              4-Bit ALU
//---------------------------------------------------------------


module alu(input [3:0]A,input [3:0]B,input [3:0]op,output reg [3:0]Y,output reg carry,);

always @(*)
begin
    carry = 1'b0;
case(op)
4'h0 : $display("ADD :");{carry,Y} = A + B;
4'h1 : $display("SUB :"); {carry,Y} = A - B;
4'h2 : $display("AND :"); Y = A & B;
4'h3 : $display("OR :"); Y = A | B;
4'h4 : $display("XOR :"); Y = A ^ B;
4'h5 : $display("NOT(A) :"); Y = ~A;
4'h6 : $display("NOR :"); Y = ~(A | B);
4'h7 : $display("INCREAMENT(1) A :"); {carry,Y} = A + 1;
4'h8 : $display("DECREAMENT(1) A"); {carry,Y} = A - 1;
4'h9 : $display("NCREAMENT(1) B :"); {carry,Y} = B + 1;
4'hA : $display("DECREAMENT(1) B :"); {carry,Y} = B - 1;
default : $display("INVALID OPERATION :");Y = 4'h0;
endcase
end

endmodule

module tb;

reg [3:0]A,B,op;
wire carry;
wire [3:0]Y;

alu dut(.A(A),.B(B).op(op),.carry(carry),.Y(Y));

initial
begin
$dumpfile("alu_.vcd");
$dumpvars(0,tb);

$monitor("TIME = %0t | A = %b | B = %b |OPERATOR = %b | Y = %b | CARRY = %b |",$time,A,B,op,Y,carry);
integer i;
for(i = 4'h0 ; i < 4'hB ; i = i + 1)
begin
op = i; #10
end
$finish;

end

endmodule