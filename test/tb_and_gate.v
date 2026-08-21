`timescale 1ns/1ps

module tb_and_gate;

// Testbench signals
reg A, B;
wire Y;

// Instantiate the AND gate
and_gate uut (
.A(A),
.B(B),
.Y(Y)
);

initial begin
// Create VCD file for GTKWave
$dumpfile("and_gate.vcd");
$dumpvars(0, tb_and_gate);

// Display output in terminal
$display("Time\tA B | Y");
$monitor("%0t\t%b %b | %b", $time, A, B, Y);

// Apply test vectors
A = 0; B = 0;
#10;

A = 0; B = 1;
#10;

A = 1; B = 0;
#10;

A = 1; B = 1;
#10;

$finish;
end

endmodule
