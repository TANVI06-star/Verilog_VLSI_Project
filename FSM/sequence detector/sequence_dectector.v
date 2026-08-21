//---------------------------------------------------------------
// MODULE : SEQUENCE DETECTOR
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              3-Bit sequence detector(101)
//---------------------------------------------------------------


module s_d(input new,input clk,output reg Y,input reset);

reg [1:0]state,next_state;
parameter S1=2'b00,S2=2'b01,S3=2'b10;

always @(posedge clk)
begin
        if(reset)
   state <= S1;     
   else
   state <= next_state;
end


always @(*)
begin
next_state = S1;

case(state)
S1 : begin
        if(new)
        next_state=S2;
        else
        next_state=S1;
        end
S2 : begin
        if(new)
        next_state=S1;
        else
        next_state=S3;
        end
S3 : begin
        if(new)
        next_state=S2;
        else
        next_state=S1;
end       
default : next_state = S1;
endcase
end


always @(*)
begin
if((state == S3) && (new == 1))
Y = 1'b1;
else
Y = 1'b0;
end

endmodule

module tb;
reg new,clk,reset;
wire Y;

s_d dut(.new(new),.clk(clk),.Y(Y),.reset(reset));

initial
begin
clk = 0;
forever #5 clk = ~clk;
end

initial
begin
$dumpfile("sequence_dect.vcd");
$dumpvars(0,tb);

$monitor("TIME = %0t | CLK = %b | reset = %b |new = 1 | Y = %b",$time,clk,reset,new,Y);
#10 reset=1;
#10 reset=0;new=1;
#10 new=1;
#10 new=1;
#10 new=0;
#10 new=1;
#10 new=1;
#10 new=0;
#10 new=0;
#10 new=1;
#10 new=1;
#10 new=0;
#10 new=1;
#10 new=0;
#10 new=1;
#10 new=0;
#10 new=1;
#10 new=1;
#10 new=1;
#10 new=0;
#10 new=1;
#10 new=1;
#10 $finish;
end


endmodule


