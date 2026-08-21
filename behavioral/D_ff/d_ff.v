module D_ff(input D,input clk,input reset,input enable,output reg Q);

always @(posedge clk)
begin
if (reset == 1)
Q <= 1'b0;
else if (enable == 1)
Q <= D;

end

endmodule


module tb;
reg D;
reg clk,enable,reset;
wire Q;

D_ff dut(.D(D),.clk(clk),.enable(enable),.reset(reset),.Q(Q));

initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial
begin
    $dumpfile("flipflop.vcd");
$dumpvars(0,tb);

$monitor("TIME = %t | D = %b | R = %b | E  = %b | Q = %b |",$time,D,reset,enable,Q);
reset = 0; enable = 1;D=1'b1;
#10 D=1'b0;
#10 D=1'b1;
#10 D=1'b0;
#10 D=1'b1;
#10 $finish;

end

endmodule