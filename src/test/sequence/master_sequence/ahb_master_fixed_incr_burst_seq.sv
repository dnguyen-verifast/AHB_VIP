`ifndef AHB_MASTER_FIXED_INCR_BURST_SEQ_INCLUDE_
`define AHB_MASTER_FIXED_INCR_BURST_SEQ_INCLUDE_

class ahb_master_fixed_incr_burst_seq extends ahb_master_base_seq;
    `uvm_object_utils(ahb_master_fixed_incr_burst_seq)

    extern function new(string name = "ahb_master_fixed_incr_burst_seq",uvm_component parent=null);
    extern task body();
endclass : ahb_master_fixed_incr_burst_seq
function ahb_master_fixed_incr_burst_seq::new(string name = "ahb_master_fixed_incr_burst_seq",uvm_component parent=null);
    super.new(name,parent);
endfunction : new

task ahb_master_fixed_incr_burst_seq::body();
    super.body();
    start_item(req_m);
    if(!req_m.randomize()) begin
        `uvm_fatal("ahb_master","Rand failed");
    end
    finish_item(req_m);
endtask : body
`endif
