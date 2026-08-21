module mux2x1(input sel,input I1,input I2,output reg Y);

always @(*)//if-else
begin 
if (sel)
Y = I1;
else
Y = I2;
end

endmodule