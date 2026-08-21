//---------------------------------------------------------------
// MODULE : MOD COUNTER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              MOD-6 COUNTER(UP)
//---------------------------------------------------------------

module mod6(input clk,input reset,output reg [2:0]Y);

always @(negedge clk)
begin
if(reset)
Y <= 3'b000;
else if (Y == 3'b101)
Y <= 3'd0;
else
Y <= Y + 1'b1;
end

endmodule

module tb;
reg clk,reset;
wire [2:0]Y;

mod6 dut(.clk(clk),.reset(reset),.Y(Y));

initial
begin
clk = 0;
forever #5 clk = ~clk;
end

initial
begin
$dumpfile("MOD6.vcd");
$dumpvars(0,tb);
$monitor("TIME = %0t | CLK = %b |RESET = %b  | COUNT = %d ",$time,clk,reset,Y);
reset=1;
#10 reset=0;
#100 $finish;
end

endmodule
