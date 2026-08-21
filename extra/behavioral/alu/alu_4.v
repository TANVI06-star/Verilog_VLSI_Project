//---------------------------------------------------------------
// MODULE : ALU
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              4-Bit ALU
//---------------------------------------------------------------


module alu_4(input [3:0]A,input [3:0]B,input [3:0]op,output reg [3:0]Y,output reg carry);

always @(*)
begin
    carry = 1'b0;
case(op)
4'h0 :begin  
    $display("ADD :");
    {carry,Y} = A + B;
    end
4'h1 :begin 
    $display("SUB :");
     {carry,Y} = A - B;
     end
4'h2 :begin 
    $display("AND :");
     Y = A & B;
     end
4'h3 :begin
     $display("OR :");
      Y = A | B;
      end
4'h4 :begin 
    $display("XOR :");
     Y = A ^ B;
     end
4'h5 :begin
     $display("NOT(A) :");
      Y = ~A;
      end
4'h6 : begin
    $display("NOR :"); 
    Y = ~(A | B);
    end
4'h7 :begin 
    $display("INCREAMENT(1) A :");
     {carry,Y} = A + 1;
     end
4'h8 :begin 
    $display("DECREAMENT(1) A"); 
    {carry,Y} = A - 1;
    end
4'h9 :begin
     $display("NCREAMENT(1) B :");
      {carry,Y} = B + 1;
      end
4'hA :begin
     $display("DECREAMENT(1) B :"); 
     {carry,Y} = B - 1;
     end
default :begin 
    $display("INVALID OPERATION :");
    Y = 4'h0;
    end
endcase
end

endmodule

module tb;

reg [3:0]A,B,op;
wire carry;
wire [3:0]Y;
integer i;

alu_4 dut(.A(A),.B(B),.op(op),.carry(carry),.Y(Y));

initial
begin
$dumpfile("alu_.vcd");
$dumpvars(0,tb);

$monitor("TIME = %0t | A = %b | B = %b |OPERATOR = %b | Y = %b | CARRY = %b |",$time,A,B,op,Y,carry);
A = 4'h9;  B = 4'h4;
for(i = 4'h0 ; i < 4'hB ; i = i + 1)
begin
 #10 op = i;
end
$finish;

end

endmodule