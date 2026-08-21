//---------------------------------------------------------------
// MODULE : REGISTER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//               4-bit register
//---------------------------------------------------------------



module register(input [3:0]D,input clk,input reset,input enable,output reg[3:0]Q);

always @(posedge clk)
begin
   if (reset) 
   Q <= 4'b0000;
   else if (enable)
   Q <= D;

end


endmodule



module tb;

reg [3:0]D;
reg clk,reset,enable;
wire [3:0]Q;

register dut(.D(D),.clk(clk),.enable(enable),.reset(reset),.Q(Q));

initial
begin
clk = 0;
forever #5 clk = ~clk;
end

initial
begin
$dumpfile("register.vcd");
$dumpvars(0,tb);

$monitor("TIME = %t | D = %b | R = %b | E  = %b | Q = %b |",$time,D,reset,enable,Q);
reset = 0; enable = 1;D=1'b1;
#10 D=1'b0;
#10 D=1'b1;reset=1'b0;
#10 D=1'b0;reset=1'b1;
#10 D=1'b1;
#10 $finish;


end


endmodule