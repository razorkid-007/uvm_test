`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"
import alu_test_pkg::*;

`include "alu_seq.svh"

module alu_top_tb;

  parameter WIDTH = 8;

  // Clock and reset
  logic clk;
  logic rst_n;

  // ALU interface
  alu_if #(WIDTH) alu_vif(clk);

  // DUT instantiation
  alu #(.WIDTH(WIDTH)) dut (
    .clk    (clk),
    .a      (alu_vif.a),
    .b      (alu_vif.b),
    .op     (alu_vif.op),
    .result (alu_vif.result),
    .carry_out (alu_vif.carry_out)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset generation
  initial begin
    rst_n = 0;
    #20;
    rst_n = 1;
  end

  // UVM configuration
  initial begin
    // Set virtual interface for UVM components
    uvm_config_db#(virtual alu_if)::set(null, "*", "vif", alu_vif);
    run_test("alu_test");
  end

endmodule