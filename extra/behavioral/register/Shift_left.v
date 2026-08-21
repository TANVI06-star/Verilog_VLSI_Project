//---------------------------------------------------------------
// MODULE : SHIFT REGISTER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              4 bit shift register (LEFT)
//---------------------------------------------------------------


module S_r(input clk,input new,input reset,output reg [3:0]Q);

always @(posedge clk)
begin
if (reset)
Q <= 4'h0;
else
Q <= {Q[2:0],new};
end


endmodule



module tb;
reg clk,reset,new;
wire [3:0]Q;

S_r dut(.clk(clk),.reset(reset),.new(new),.Q(Q));

initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial
begin
    $dumpfile("left_reg.vcd");
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