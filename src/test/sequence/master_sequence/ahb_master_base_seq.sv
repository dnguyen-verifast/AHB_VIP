`ifndef AHB_MASTER_SEQ_BASE_INCLUDED_
`define AHB_MASTER_SEQ_BASE_INCLUDED_


class ahb_master_base_seq extends uvm_sequence #(ahb_master_tx);
  `uvm_object_utils(ahb_master_base_seq)
    ahb_master_tx req_m;

  extern function new(string name = "ahb_master_base_seq");
  extern task body();
endclass : ahb_master_base_seq

function ahb_master_base_seq::new(string name = "ahb_master_base_seq");
  super.new(name);
endfunction : new
task ahb_master_base_seq::body();

  req_m = ahb_master_tx::type_id::create("req_m");
endtask : body
`endif
