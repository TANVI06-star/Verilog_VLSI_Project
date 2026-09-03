//---------------------------------------------------------------
// MODULE : TRAFFIC LIGHT CONTROLLER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              Traffic light controller using FSM concept.(2 PROCESS)
//---------------------------------------------------------------

module tl(input clk,input reset,output reg [2:0]SIGNAL);

//STATE DECLARATION AND COUTER
reg [1:0]state,next_state;
reg [3:0]count;

/* STATE ENCODING 
STATE : RED : UNTILL CUNT REACHES 9 THEN MOVE TO YELLOW
        GREEN : UNTILL COUNT REACHES 9 THEN MOVE TO RED
        YELLOW: UNTILL COUNT REACHES 3 THEN MOVE TO GREEN
*/
parameter RED=2'b00,YELLOW=2'b01,GREEN=2'b10;

parameter RED_TIME=5,YELLOW_TIME=3,GREEN_TIME=5;

//STATE REGISTER
always @(posedge clk)
begin
if(reset)
begin
state <= RED;
count <= 3'b0;
end
else 
begin
state <= next_state;

if ((state == RED) && (count == RED_TIME))
count <= 1'b0;
else if ((state == YELLOW) && (count == YELLOW_TIME))
count <= 1'b0;
else if ((state == GREEN) && (count == GREEN_TIME))
count <= 1'b0;
else
count <= count + 1'b1;

end

end

//NEXT STATE LOGIC
always @(*)
begin
next_state = RED;
case(state)
RED : begin
        if(count < RED_TIME)begin
                  next_state = RED;
                  SIGNAL = 3'b100;
                
        end
        else begin
              next_state = YELLOW;
              SIGNAL = 3'b010;
        end

        end
YELLOW : begin
        if(count < YELLOW_TIME)begin
                  next_state = YELLOW;
                  SIGNAL = 3'b010;
        end
        else begin
              next_state = GREEN;
              SIGNAL = 3'b001;
        end
end
GREEN : begin
        if(count < GREEN_TIME)begin
                  next_state = GREEN;
                  SIGNAL = 3'b001;
        end
        else begin
              next_state = RED;
              SIGNAL = 3'b100;
        end
end
default : begin
        next_state = RED;
        SIGNAL = 3'b100;
end
endcase
end


endmodule

//TEST BENCH

`timescale 1ns/1ps
module tb;
reg clk,reset;
wire [2:0]signal;

//driver
tl dut(.clk(clk),.reset(reset),.SIGNAL(signal));

//clock generation
initial
begin
clk = 0;
forever #1 clk = ~clk;
end


initial
begin
$dumpfile("traffic_light.vcd");
$dumpvars(0,tb);

//monitoring
$monitor("TIME = %0t |  |COUNT = %d | STATE = %b | SIGNAL = %b",$time,dut.count,dut.state,signal);

//INITIALIZING CLOCK
reset=1;
#10 reset =0;
#100 $finish;

end

//CHECKING SAFETY PROPERTY
always @(posedge clk)
begin
        if(((|signal) != 1 ))
        begin
                $display("FAIL");
        end
        else
        $display("PASS.");
end


endmodule

