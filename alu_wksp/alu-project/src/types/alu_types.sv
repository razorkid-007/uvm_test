// This file defines custom types and constants used in the ALU design.
// It includes enumerations for operation types and other relevant data structures.

typedef enum logic [2:0] {
    OP_ADD = 3'b000,
    OP_SUB = 3'b001,
    OP_AND = 3'b010,
    OP_OR  = 3'b011,
    OP_XOR = 3'b100,
    OP_NAND = 3'b101,
    OP_NOR  = 3'b110,
    OP_XNOR = 3'b111
} alu_op_t;

typedef struct packed {
    logic [7:0] operand_a;
    logic [7:0] operand_b;
    alu_op_t operation;
} alu_input_t;

typedef struct packed {
    logic [8:0] result;
    logic overflow;
    logic zero;
} alu_output_t;