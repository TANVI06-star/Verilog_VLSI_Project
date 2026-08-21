//---------------------------------------------------------------
// MODULE : FOUR-BIT ADDER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              Four bit adder using design flow (RTL Modelling)
//---------------------------------------------------------------

// HALF ADDER
`timescale 1ns/1ps
module half_adder(input A,input B,output SUM,output CARRY);
assign SUM = A ^ B;
assign CARRY = A & B;
endmodule

// OR GATE 
module or_gate(input A, input B,output Y);
assign Y = A | B;
endmodule

// TOP MODULE FULL ADDER
module full_adder(input A,input B,input Cin,output SUM,output Cout);
wire CARRY_OUTPUT , Y2 ,SUM_OUTPUT;

half_adder u1(.A(A),.B(B),.SUM(SUM_OUTPUT),.CARRY(CARRY_OUTPUT));
half_adder u2(.A(SUM_OUTPUT),.B(Cin),.SUM(SUM),.CARRY(Y2));
or_gate u3(.A(CARRY_OUTPUT),.B(Y2),.Y(Cout));

endmodule

module fourbit_adder(input [3:0]A,input [3:0]B,input Cin,output [3:0]Sum,output COUT);

wire C1,C2,C3;

full_adder U1(.A(A[0]),.B(B[0]),.Cin(Cin),.SUM(Sum[0]),.Cout(C1));
full_adder U2(.A(A[1]),.B(B[1]),.Cin(C1),.SUM(Sum[1]),.Cout(C2));
full_adder U3(.A(A[2]),.B(B[2]),.Cin(C2),.SUM(Sum[2]),.Cout(C3));
full_adder U4(.A(A[3]),.B(B[3]),.Cin(C3),.SUM(Sum[3]),.Cout(COUT));

endmodule

module tb;

wire [3:0]sum;
wire carry;
reg [3:0]A,B;
reg cin;

fourbit_adder uut(.A(A),.B(B),.Cin(cin),.Sum(sum),.COUT(carry));


initial 
    begin
        $dumpfile("fourbit_adder.vcd");
        $dumpvars(0, tb);

        $monitor("Time = %0t | A = %b, B = %b, Cin = %b, COUT = %b, SUM = %b",
             $time, A, B, cin, carry, sum);

        #10    A=4'b1010;B=4'b0101;cin=1'b0;
        #10 A=4'b1110;B=4'b0111;cin=1'b0;
        #10 $finish;
             
    end
    


endmodule
