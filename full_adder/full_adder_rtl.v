//---------------------------------------------------------------
// MODULE : FULL ADDER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              Full adder using design flow (RTL Modelling)
//---------------------------------------------------------------

// HALF ADDER
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
