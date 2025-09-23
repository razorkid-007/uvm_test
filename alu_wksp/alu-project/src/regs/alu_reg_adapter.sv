class alu_reg_adapter extends uvm_reg_adapter;
  `uvm_object_utils(alu_reg_adapter)

  function new(string name = "alu_reg_adapter");
    super.new(name);
  endfunction

  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    alu_seq_item item = alu_seq_item::type_id::create("item");
    item.op = (rw.kind == UVM_READ) ? alu_types::READ : alu_types::WRITE;
    item.addr = rw.addr;
    item.data = rw.data;
    return item;
  endfunction

  virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    alu_seq_item item;
    if (!$cast(item, bus_item)) begin
      `uvm_fatal("ADAPTER", "Failed to cast bus_item to alu_seq_item")
    end
    rw.kind = (item.op == alu_types::READ) ? UVM_READ : UVM_WRITE;
    rw.addr = item.addr;
    rw.data = item.data;
    rw.status = UVM_IS_OK;
  endfunction
endclass
