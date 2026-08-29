//---------------------------------------------------------------
// MODULE : 4-BIT ADDER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              A 4-bit adder using self-testing test bench
//---------------------------------------------------------------


// 4 BIT ADDER LOGIC
module adder(input [3:0]A,input [3:0]B,output reg [3:0]Y,output reg C);

always @(*)
begin
    {C,Y} = A + B;
end
endmodule

//SELF CHECKING TEST BENCH
//`timescale 1ns/1ps
module tb;

reg [3:0]A,B;
wire [3:0]Y;
reg [3:0]expected;
reg carry;
wire C;
integer i;
integer error;

// Driver
adder DUT(.A(A),.B(B),.C(C),.Y(Y));

//Wave form
initial
begin
    $dumpfile("adder.vcd");
    $dumpvars(0,tb);
end

initial
begin
    
    //Monitor
    $monitor("TIME = %0t | %b + %b = %b %b",$time,A,B,C,Y);

    error = 0;
    for(i=0;i<20;i=i+1)
    begin
       
    //Generator
    A = $random;
    B = $random;

    {carry,expected} = A + B;

    #1;

    //Scorecard
    if ((Y != expected) || (C != carry))
    begin
        error = error + 1;
        $display("FAIL");
    end
    else
     $display("PASS");

    end

    if(error == 0)
    $display("***************TEST IS SUCCESSFULL****************** (ERROR = %d)",error);
    else
    $display("***************TEST IS UNSUCCESSFULL****************** (ERROR = %d)",error);


end




endmodule