//---------------------------------------------------------------
// MODULE : TRAFFIC LIGHT CONTROLLER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              Traffic light controller using FSM concept.(3 PROCESS)
//---------------------------------------------------------------

module tl(input clk,input reset,output reg Y,output reg [2:0]SIGNAL);

reg [1:0]state,next_state;
reg [3:0]count;
parameter RED=2'b00,YELLOW=2'b01,GREEN=2'b10;

always @(posedge clk)
begin
if(reset)
begin
state <= RED;
count <= 0;
end
else
state <= next_state;
end

always @(*)
begin
next_state = RED;
case(state)
RED : begin
        if(count < 9)begin
                  next_state = RED;
                  SIGNAL = 3'b100;
                count = count + 1;
                
        end
        else begin
              next_state = YELLOW;
              SIGNAL = 3'b010;
                count = 0;
        end

        end
YELLOW : begin
        if(count < 3)begin
                  next_state = YELLOW;
                  SIGNAL = 3'b010;
                count = count + 1;
                
        end
        else begin
              next_state = GREEN;
              SIGNAL = 3'b001;
                count = 0;
        end
end
GREEN : begin
        if(count < 9)begin
                  next_state = GREEN;
                  SIGNAL = 3'b001;
                count = count + 1;
                
        end
        else begin
              next_state = RED;
              SIGNAL = 3'b100;
                count = 0;
        end
end
default : begin
        next_state = RED;
        SIGNAL = 3'b100;
end
endcase
end

always @(*)
begin
        if(state == GREEN && count == 9)
        Y = 1'b1;
        else
        Y = 1'b0;
end

endmodule

module tb;
reg clk,reset;
wire Y;
wire [2:0]signal;

tl dut(.clk(clk),.reset(reset),.Y(Y),.SIGNAL(signal));

initial
begin
clk = 0;
forever #5 clk = ~clk;
end

initial
begin
$dumpfile("traffic_light.vcd");
$dumpvars(0,tb);

$monitor("TIME = %0t | clk = %b | Y =%b | SIGNAL = %b",$time,clk,Y,signal);
reset=1;
#12 reset=0;

#100 $finish;

end

endmodule

