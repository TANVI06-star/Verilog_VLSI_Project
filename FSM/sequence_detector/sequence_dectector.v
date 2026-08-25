//---------------------------------------------------------------
// MODULE : SEQUENCE DETECTOR
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              3-Bit sequence detector(101) using Mealy fsm
//---------------------------------------------------------------


module s_d(input new,input clk,output reg Y,input reset);

//STATE DECLARATION
reg [1:0]state,next_state;

/*STATE ENCODING
STATES : S1 : IF 1 IS DETECTED MOVE TO S2
         S2 : IF 0 IS DETECTED MOVE TO S3
         S3 : IF 1 IS DETECTED MOVE TO S2(OVERLAPPING IS HAPPENING)
         */
parameter S1=2'b00,S2=2'b01,S3=2'b10;

//STATE REGISTER
always @(posedge clk)
begin
        if(reset)
   state <= S1;     
   else
   state <= next_state;
end

//NEXT STATE LOGIC
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

//OUTPUT LOGIC
always @(*)
begin
if((state == S3) && (new == 1))
Y = 1'b1;
else
Y = 1'b0;
end

endmodule

//TEST BENCH
module tb;
reg new,clk,reset;
wire Y;

s_d dut(.new(new),.clk(clk),.Y(Y),.reset(reset));

//USING TASK FOR THE INPUTS
task seq;
input i;
begin
        new = i;
        #10;
end
endtask

initial
begin
clk = 0;
forever #5 clk = ~clk;
end

initial
begin
$dumpfile("sequence_dect.vcd");
$dumpvars(0,tb);

$monitor("TIME = %0t | CLK = %b | reset = %b |new = %b Y = %b",$time,clk,reset,new,Y);
#10 reset=1;
#10 reset=0;
seq(1);
seq(0);
seq(1);
seq(1);
seq(1);
seq(1);
seq(0);
seq(0);
seq(1);
seq(0);
seq(1);
seq(1);
seq(0);
seq(1);
#10 $finish;
end


endmodule


