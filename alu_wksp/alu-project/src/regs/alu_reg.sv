class alu_reg extends uvm_reg;
  `uvm_object_utils(alu_reg)

  rand uvm_reg_field A;
  rand uvm_reg_field B;
  rand uvm_reg_field op;

  function new(string name = "alu_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    A = uvm_reg_field::type_id::create("A");
    A.configure(this, 8, 0, "RW", 0, 8'h0, 1, 1, 1);

    B = uvm_reg_field::type_id::create("B");
    B.configure(this, 8, 8, "RW", 0, 8'h0, 1, 1, 1);

    op = uvm_reg_field::type_id::create("op");
    op.configure(this, 2, 16, "RW", 0, 2'h0, 1, 1, 1);
  endfunction
endclass
