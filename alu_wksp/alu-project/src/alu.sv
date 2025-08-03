// Simple Arithmetic Logic Unit (ALU) implementation
module ALU(
  input logic clk,
  input logic [7:0] a,
  input logic [7:0] b,
  input logic [2:0] op, // Operation selector
  output logic [8:0] result,
  output logic overflow
);

  always_ff @(posedge clk) begin
    case (op)
      3'b000: begin // Addition
        {overflow, result} <= a + b;
      end
      3'b001: begin // Subtraction
        {overflow, result} <= a - b;
      end
      3'b010: begin // AND
        result <= a & b;
        overflow <= 0;
      end
      3'b011: begin // OR
        result <= a | b;
        overflow <= 0;
      end
      3'b100: begin // XOR
        result <= a ^ b;
        overflow <= 0;
      end
      default: begin
        result <= 0;
        overflow <= 0;
      end
    endcase
  end

endmodule: ALU