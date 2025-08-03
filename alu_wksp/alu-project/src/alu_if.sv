interface alu_if #(parameter WIDTH = 8) (input logic clk);
  logic [WIDTH-1:0] a, b;
  logic [2:0] op;
  logic [WIDTH-1:0] result;
  logic carry_out;
  
  clocking cb @(posedge clk);
    output a, b, op;
    input result, carry_out;
  endclocking
endinterface