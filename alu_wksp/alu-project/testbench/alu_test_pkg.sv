// UVM package for ALU testbench

package alu_test_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // Forward declarations
  class alu_seq_item;
  class alu_seq;
  class alu_driver;
  class alu_monitor;
  class alu_agent;
  class alu_env;
  class alu_scoreboard;
  class alu_test;

  // Sequence item
  class alu_seq_item extends uvm_sequence_item;
    rand bit [7:0] a, b;
    rand bit [2:0] op;
    bit [7:0] result;
    bit carry_out;
    `uvm_object_utils(alu_seq_item)
    function new(string name = "alu_seq_item"); super.new(name); endfunction
  endclass

  // Sequence
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

  // Driver
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

  // Monitor
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

  // Scoreboard
  class alu_scoreboard extends uvm_component;
    uvm_analysis_imp #(alu_seq_item, alu_scoreboard) ap;
    function new(string name = "alu_scoreboard", uvm_component parent); super.new(name, parent); ap = new("ap", this); endfunction
    virtual function void write(alu_seq_item item);
      bit [7:0] expected;
      case (item.op)
        3'b000: expected = item.a + item.b;
        3'b001: expected = item.a - item.b;
        default: expected = 8'hxx;
      endcase
      if (item.result !== expected)
        `uvm_error("ALU_SCB", $sformatf("Mismatch: a=%h b=%h op=%b result=%h expected=%h", item.a, item.b, item.op, item.result, expected))
    endfunction
  endclass

  // Agent
  class alu_agent extends uvm_agent;
    alu_driver drv;
    alu_monitor mon;
    uvm_sequencer #(alu_seq_item) seqr;
    function new(string name, uvm_component parent); super.new(name, parent); endfunction
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      drv = alu_driver::type_id::create("drv", this);
      mon = alu_monitor::type_id::create("mon", this);
      seqr = uvm_sequencer#(alu_seq_item)::type_id::create("seqr", this);
    endfunction
    virtual function void connect_phase(uvm_phase phase);
      drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction
  endclass

  // Environment
  class alu_env extends uvm_env;
    alu_agent agent;
    alu_scoreboard scb;
    function new(string name, uvm_component parent); super.new(name, parent); endfunction
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      agent = alu_agent::type_id::create("agent", this);
      scb = alu_scoreboard::type_id::create("scb", this);
    endfunction
    virtual function void connect_phase(uvm_phase phase);
      agent.mon.ap.connect(scb.ap);
    endfunction
  endclass

  // Test
  class alu_test extends uvm_test;
    alu_env env;
    function new(string name, uvm_component parent); super.new(name, parent); endfunction
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = alu_env::type_id::create("env", this);
    endfunction
    virtual task run_phase(uvm_phase phase);
      alu_seq seq = alu_seq::type_id::create("seq");
      seq.start(env.agent.seqr);
      phase.raise_objection(this);
      #100;
      phase.drop_objection(this);
    endtask
  endclass

endpackage: alu_test_pkg