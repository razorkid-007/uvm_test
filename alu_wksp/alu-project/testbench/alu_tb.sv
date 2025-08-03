// Testbench for the ALU
module alu_tb;

  // Parameters
  parameter WIDTH = 8;

  // Signals
  reg clk;
  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  reg [2:0] op; // Operation selector
  wire [WIDTH-1:0] result;
  wire carry_out;

  // Instantiate the ALU
  alu #(.WIDTH(WIDTH)) uut (
    .clk(clk),
    .a(a),
    .b(b),
    .op(op),
    .result(result),
    .carry_out(carry_out)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units period
  end

  // Test procedure
  initial begin
    // Initialize inputs
    a = 8'h00;
    b = 8'h00;
    op = 3'b000; // Example operation code for addition

    // Test addition
    #10 a = 8'h05; b = 8'h03; op = 3'b000; // Add 5 + 3
    #10; // Wait for result
    // Check result
    if (result !== 8'h08) $display("Error: Expected 8, got %h", result);

    // Test subtraction
    #10 a = 8'h0A; b = 8'h04; op = 3'b001; // Subtract 10 - 4
    #10; // Wait for result
    // Check result
    if (result !== 8'h06) $display("Error: Expected 6, got %h", result);

    // Add more test cases as needed

    // Finish simulation
    #10 $finish;
  end

endmodule: alu_tb