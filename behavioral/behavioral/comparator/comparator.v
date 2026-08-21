module comparator(input [3:0]A,input [3:0]B);

always @(*)
begin
if (A > B)
$display("%b is greator than %b .",A,B);
else
$display("%b is greator than %b .",B,A);
end

endmodule