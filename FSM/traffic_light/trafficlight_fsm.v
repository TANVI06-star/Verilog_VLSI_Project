//---------------------------------------------------------------
// MODULE : TRAFFIC LIGHT CONTROLLER
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//              Traffic light controller using FSM concept.(3 PROCESS)
//---------------------------------------------------------------

module tl(input clk,input reset,output reg Y,output reg [2:0]SIGNAL);

//STATE DECLARATION AND COUTER
reg [1:0]state,next_state;
reg [3:0]count;

/* STATE ENCODING 
STATE : RED : UNTILL CUNT REACHES 9 THEN MOVE TO YELLOW
        GREEN : UNTILL COUNT REACHES 9 THEN MOVE TO RED
        YELLOW: UNTILL COUNT REACHES 3 THEN MOVE TO GREEN
*/
parameter RED=2'b00,YELLOW=2'b01,GREEN=2'b10;

//STATE REGISTER
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

//NEXT STATE LOGIC
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

//OUTPUT LOGIC
always @(*)
begin
        if(state == GREEN && count == 9)
        Y = 1'b1;
        else
        Y = 1'b0;
end

endmodule

//TEST BENCH

`timescale 1ns/1ps
module tb;
reg clk,reset;
wire Y;
wire [2:0]signal;

tl dut(.clk(clk),.reset(reset),.Y(Y),.SIGNAL(signal));

//clock generation
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

//INITIALIZING CLOCK
reset=1;
#12 reset=0;

#100 $finish;

end

endmodule

