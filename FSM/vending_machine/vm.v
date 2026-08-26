//---------------------------------------------------------------
// MODULE : VENDING MACHINE
// AUTHOR : TANVI NARIYA
// DESCRIPTION :
//               VENDING MACHINE WHICH DISPENSE WHEN AMOUNT 
//               10$ AND 15$ inserted.
//---------------------------------------------------------------
module vm(input clk,input reset,input coin10,input coin5,output reg dispense);

//STATE DECLARATION
reg [2:0]state,next_state;

/*STATE ENCODING
STATES S0: WHEN NO COIN INSERTED
        S5 : COIN OF 5 IS INSERTED
        S10 : COIN 10 IS INSERTED
*/
parameter S0 = 3'b001,S5 = 3'b010,S10 = 3'b100;

//STATE REGISTER
always @(posedge clk)
begin
if(reset)
state <= S0;
else
state <= next_state;
end

//NEXT STATE LOGIC
always @(*)
begin
next_state = S0;
case(state)
S0 : begin
    if(coin5)
    next_state = S5;
    else if(coin10)
    next_state = S10;
end
S5 :  begin
    if(coin5)
    next_state = S10;
    else if(coin10)
    next_state = S0;
end
S10 : begin
    if(coin5)
    next_state = S0;
    else 
    next_state = S10;
end
default : next_state = S0;
endcase
end

//OUTPUT LOGIC
always @(*)
begin
    if(state == S5 && (coin10 | coin5))
        dispense = 1;
    else if ((state == S10) && coin5)
        dispense = 1;
    else if((state == S0) && coin10)
    dispense = 1;
    else
    dispense = 0;


end

endmodule



//TEST BENCH
`timescale 1ns/1ps
module tb;
reg clk,reset,coin5,coin10;
wire Y;

vm dut(.clk(clk),.reset(reset),.coin5(coin5),.coin10(coin10),.dispense(Y));

always #5 clk = ~clk;

task coins;
input c5,c10;
begin
coin5 = c5;
coin10 = c10;
end
endtask

initial 
begin
$dumpfile("vm_.vcd");
$dumpvars(0,tb);

$monitor("TIME = %0t | clk =%b | coin5 = %b | coin10 = %b | DISPENSE = %b",$time,clk,coin5,coin10,Y);
clk = 0;reset = 1;coin5 = 1;coin10 = 0;
#10 reset = 0;

// ₹5 → total ₹5
#10 coins(1,0);

// ₹5 → total ₹10 → DISPENSE
#10 coins(1,0);

// No coin
#10 coins(0,0);

// ₹10 → total ₹10 → DISPENSE
#10 coins(0,1);

// No coin
#10 coins(0,0);

// ₹5 → total ₹5
#10 coins(1,0);

// ₹10 → total ₹15 → DISPENSE
#10 coins(0,1);

#10 $finish;

end


endmodule
