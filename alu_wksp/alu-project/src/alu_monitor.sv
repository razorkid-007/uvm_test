class alu_monitor extends uvm_monitor;
  virtual alu_if vif;
  uvm_analysis_port #(alu_seq_item) ap;
  function new(string name = "alu_monitor", uvm_component parent); super.new(name, parent); ap = new("ap", this); endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "No virtual interface specified for monitor")
  endfunction
  virtual task run_phase(uvm_phase phase);
    alu_seq_item item = alu_seq_item::type_id::create("item");
    forever begin
      @(posedge vif.clk);
      item.a = vif.a;
      item.b = vif.b;
      item.op = vif.op;
      item.result = vif.result;
      item.carry_out = vif.carry_out;
      ap.write(item);
    end
  endtask
endclass