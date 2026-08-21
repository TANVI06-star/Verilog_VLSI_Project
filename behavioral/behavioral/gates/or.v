//---------------------------------------------------------------
// MODULE : OR
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              OR -XOR-2:1 MUX gate using behavioural modelling
//---------------------------------------------------------------

module or_gate(input A,input B,output reg Y);

always @(*)
begin 
Y = A | B;//blocking statements
end

endmodule


