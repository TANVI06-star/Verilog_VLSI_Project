//---------------------------------------------------------------
// MODULE : COUNTER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//               4- bit counter
//---------------------------------------------------------------


module count(input clk,input reset,input up,output reg [3:0]Q);

always @(posedge clk)
begin
if ((reset == 1) || (Q == 4'hF))
Q <= 4'h0;
else if (up)
Q <= Q + 1;
else if ((up == 0) && (Q == 4'h0))
Q <= 4'hF;
else
Q <= Q - 1;
end

endmodule



module tb;
reg clk,up,reset;
wire [3:0]Q;

count dut(.clk(clk),.reset(reset),.up(up),.Q(Q));

initial 
begin
clk = 0;
forever #5 clk = ~clk;
end

initial
begin
$dumpfile("Counter.vcd");
$dumpvars(0,tb);

$monitor("TIME = %0t | CLK = %b |RESET = %b | UP = %b | COUNT = %b ",$time,clk,reset,up,Q);
reset=1;up=1;
#10 reset=0; up=1;
#10 up=1;
#10 up=1;
#10 up=1;
#10 up=0;
#10 up=0;
#10 up=0;
#10 up=0;
#10 $finish;

end



endmodule