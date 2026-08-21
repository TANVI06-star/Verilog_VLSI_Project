//---------------------------------------------------------------
// MODULE : HALF ADDER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              Half adder using Data flow Modelling
//---------------------------------------------------------------

module half_adder(input A,input B,output SUM,output CARRY);
assign SUM = A ^ B;
assign CARRY = A & B;
endmodule