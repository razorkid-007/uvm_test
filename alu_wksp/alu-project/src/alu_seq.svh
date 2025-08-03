class alu_seq_item extends uvm_sequence_item;
  rand bit [7:0] a, b;
  rand bit [2:0] op;
  bit [7:0] result;
  bit carry_out;
  `uvm_object_utils(alu_seq_item)
  function new(string name = "alu_seq_item"); super.new(name); endfunction
endclass

class alu_seq extends uvm_sequence #(alu_seq_item);
  `uvm_object_utils(alu_seq)
  function new(string name = "alu_seq"); super.new(name); endfunction

  virtual task body();
    alu_seq_item req;
    req = alu_seq_item::type_id::create("req");
    // Example: add test
    req.a = 8'h05; req.b = 8'h03; req.op = 3'b000;
    start_item(req); finish_item(req);
    // Example: sub test
    req.a = 8'h0A; req.b = 8'h04; req.op = 3'b001;
    start_item(req); finish_item(req);
    // Add more as needed
  endtask
endclass