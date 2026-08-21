//---------------------------------------------------------------
// MODULE : UART PROTOCOL
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//               UART( 2 Process FSM)
//---------------------------------------------------------------


module uart_fsm(input [7:0]data,input clk,input reset,input start,output reg transmit_data);

reg [1:0]state,next_state;
reg [2:0]count;

reg [7:0]D;

parameter IDLE=1'b0,DATA=1'b1;

//STATE REGISTER
always @(posedge clk)
begin
if(reset) begin
state <= IDLE;
D <= 8'b0;
end
else begin
state <= next_state;
if(!start && state == IDLE)
        D <= data;
else if(state == DATA && count != 3'd7)
        D <= D >> 1;
end
end


//COUNTER
always @(posedge clk)
begin
    
if(reset)
count <= 3'b000;
else if(state == DATA)
begin
    if(count == 3'd7)begin
    transmit_data <= D[0];
    count <= 3'b0;
end
else begin
    count <= count + 1;
    transmit_data <= D[0];
end
end
else
count <= 3'b000;
end

//NEXT STATE LOGIC
always @(*)
begin
next_state = IDLE;
case(state)
IDLE :begin
if(start == 0)
next_state = DATA;
else
next_state = IDLE;
end
DATA :begin
if(count == 3'd7)
next_state = IDLE;
else 
    next_state = DATA;
end
default : next_state = IDLE;
endcase
end



endmodule


module tb;
reg clk,start,reset;
reg [7:0]data;
wire Y;

uart_fsm dut(.clk(clk),.data(data),.reset(reset),.start(start),.transmit_data(Y));

initial
begin
clk = 0;
forever #5 clk = ~clk;
end

initial
begin
$dumpfile("uart_fsm.vcd");
$dumpvars(0,tb);

$monitor("TIME = %0t | Clk = %b | Start = %b | Data = %b | TRANSMITTED DATA = %b ",$time,clk,start,data,Y);
start = 0;data = 8'h9C; reset=1;
#5 reset =0;
#100 $finish;

end

endmodule