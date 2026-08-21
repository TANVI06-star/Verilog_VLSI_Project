//---------------------------------------------------------------
// MODULE : COUNTER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//               MOD-10 counter
//---------------------------------------------------------------

module count_10(input clk,input reset,input up,output reg [3:0]Q);

always @(posedge clk)
begin
if (reset == 1)
Q <= 4'h0;
else if((up == 0) && (Q == 4'h0))
Q <= 4'h9;
else if ((Q == 4'h9)&&(up == 1))
Q <= 4'h0;
else if((up == 1))
Q <= Q + 1;
else
Q <= Q - 1;
end

endmodule


module tb;
reg clk,reset,up;
wire [3:0]Q;

count_10 dut(.clk(clk),.reset(reset),.up(up),.Q(Q));

initial
begin
clk = 0;
forever #5 clk = ~clk;
end

initial
begin
$dumpfile("MOD_10.vcd");
$dumpvars(0,tb);
$monitor("TIME = %0t | CLK = %b |RESET = %b | UP = %b | COUNT = %b ",$time,clk,reset,up,Q);
reset=1;up=1;
#10 reset=0; up=1;
#60 up=0;
#150 $finish;
end

endmodule

