//---------------------------------------------------------------
// MODULE : FOUR-BIT ADDER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              Four bit adder using data flow 
//---------------------------------------------------------------


module four_bit_adder(input [3:0]A,input [3:0]B,input cin,output [3:0]SUM,output CARRY);
assign {CARRY,SUM} = A + B + cin;
endmodule

module tb;
reg [3:0]A,B;
reg cin;
wire [3:0]sum;
wire carry;

four_bit_adder dut(.A(A),.B(B),.SUM(sum),.CARRY(carry),.cin(cin));

initial
begin
$dumpfile("four_bit_adder.vcd");
$dumpvars(0,tb);

$monitor("Time : %0t | A = %b |B = %b |cin = %b | CARRY = %b |SUM = %b ",$time,A,B,cin,carry,sum);

#10 A=4'b0011;B=4'b1000;cin=1'b0;
#10 A=4'b1111;B=4'b1010;cin=1'b0;
#10 A=4'b0011;B=4'b1100;cin=1'b1;
#10 $finish;

end
endmodule