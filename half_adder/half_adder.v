//---------------------------------------------------------------
// MODULE : HALF ADDER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              Half adder using design flow (RTL Modelling)
//---------------------------------------------------------------

//And gate module
module and_gate(input A,input B,output Y);
assign Y = A & B;
endmodule

// Or gate module
module or_gate(input A,input B,output Y);
assign Y = A | B;
endmodule

// Xor gate module
module xor_gate(input A,input B,output Y);
assign Y = A ^ B;
endmodule

//Top module of half adder
module half_adder(input L,input M,output SUM,output CARRY);
and_gate U1(.A(L),.B(M),.Y(CARRY));
xor_gate U2(.A(L),.B(M),.Y(SUM));
endmodule

