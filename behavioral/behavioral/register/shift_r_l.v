//---------------------------------------------------------------
// MODULE : SHIFT REGISTER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              4 bit shift register (LEFT-RIGHT)
//---------------------------------------------------------------



module s_l_r(input clk,input reset,input right,input new,output reg [3:0]Q);

always @(posedge clk)
begin
if (reset)
Q <= 4'h0;
else if (right)
Q <= {new,Q[3:1]};
else
Q <= {Q[2:0],new};
end

endmodule



module tb;

reg clk,reset,new,right;
wire [3:0]Q;

s_l_r dut(.clk(clk),.reset(reset),.new(new),.right(right),.Q(Q));

initial 
begin
clk =0;
forever #5 clk = ~clk;
end

initial
begin
$dumpfile("shift_l_r.vcd");
$dumpvars(0,tb);
$monitor("TIME = %0t | new = %b | right = %b | Q = %b | clk = %b",$time,new,right,Q,clk);
reset=1'b1;right=1'b1;
#10 new=1'b1;reset=1'b0;
#10 new=1'b1;
#10 new=1'b1;
#4 new=1'b1;right=1'b0;
#5 new=1'b1;
#8 new=1'b1;
#3 new=1'b1;
#10 $finish;


end



endmodule