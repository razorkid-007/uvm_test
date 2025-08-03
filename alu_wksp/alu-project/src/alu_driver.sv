class alu_driver extends uvm_driver #(alu_seq_item);
  virtual alu_if vif;
  function new(string name = "alu_driver", uvm_component parent); super.new(name, parent); endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "No virtual interface specified for driver")
  endfunction
  virtual task run_phase(uvm_phase phase);
    alu_seq_item req;
    forever begin
      seq_item_port.get_next_item(req);
      vif.cb.a <= req.a;
      vif.cb.b <= req.b;
      vif.cb.op <= req.op;
      @(posedge vif.clk);
      seq_item_port.item_done();
    end
  endtask
endclass