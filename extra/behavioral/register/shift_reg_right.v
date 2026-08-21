//---------------------------------------------------------------
// MODULE : SHIFT REGISTER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              4 bit shift register (RIGHT)
//---------------------------------------------------------------


module S_reg(input clk,input reset,input new,output reg [3:0]Q);


always @(posedge clk)
begin
if (reset)
Q <= 4'h0;
else
Q <= {new,Q[3:1]};


end

endmodule


module tb;

reg clk,reset,new;
wire [3:0]Q;

S_reg dut(.clk(clk),.reset(reset),.new(new),.Q(Q));

initial
begin
clk = 0;
forever #5 clk = ~clk;
end

initial
begin
$dumpfile("Shift_right.vcd");
$dumpvars(0,tb);

$monitor("TIME = %0t | Q = %b | new = %b | clk = %b | reset = %b",$time,Q,new,clk,reset);

reset=1;new=1;
#10 reset=0;
#10 new=1;
#10 new=0;
#10 new=1;
#10 new=1;
#10 new=1;
#10 new=1;
#10 $finish;

end



endmodule