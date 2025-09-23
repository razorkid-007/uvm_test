class alu_reg_block extends uvm_reg_block;
  `uvm_object_utils(alu_reg_block)

  rand alu_reg alu_op_reg;

  function new(string name = "alu_reg_block");
    super.new(name);
  endfunction

  virtual function void build();
    alu_op_reg = alu_reg::type_id::create("alu_op_reg");
    alu_op_reg.configure(this, null, "");
    alu_op_reg.build();

    default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN, 0);
    default_map.add_reg(alu_op_reg, `UVM_REG_ADDR_WIDTH'h0, "RW");
  endfunction
endclass
