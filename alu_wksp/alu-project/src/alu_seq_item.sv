class alu_seq_item extends uvm_sequence_item;
  rand bit [7:0] a, b;
  rand bit [2:0] op;
  bit [7:0] result;
  bit carry_out;
  `uvm_object_utils(alu_seq_item)
  function new(string name = "alu_seq_item"); super.new(name); endfunction
endclass