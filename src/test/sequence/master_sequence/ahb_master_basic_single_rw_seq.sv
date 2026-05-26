`ifndef AHB_MASTER_BASIC_SINGLE_RW_SEQ_INCLUDE_
`define AHB_MASTER_BASIC_SINGLE_RW_SEQ_INCLUDE_

class ahb_master_basic_single_rw_seq extends ahb_master_base_seq;
    `uvm_object_utils(ahb_master_basic_single_rw_seq)

    extern function new(string name = "ahb_master_basic_single_rw_seq");
    extern task body();
endclass : ahb_master_basic_single_rw_seq
function ahb_master_basic_single_rw_seq::new(string name = "ahb_master_basic_single_rw_seq");
    super.new(name);
endfunction : new

task ahb_master_basic_single_rw_seq::body();
   do_burst_transfer(32'h1000_0000, 1'b1, 3'b011, 3'b010); 
endtask : body
`endif