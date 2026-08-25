module traffic_light(input [1:0]L,output reg [2:0]Y);

always @(*)
begin
case(L)
2'b00 : Y = 3'b100;
2'b01 : Y = 3'b010;
2'b10 : Y = 3'b001;
2'b11 : Y = 3'b000;
default : Y = 0;
endcase
end

endmodule