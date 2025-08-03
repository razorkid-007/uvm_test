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