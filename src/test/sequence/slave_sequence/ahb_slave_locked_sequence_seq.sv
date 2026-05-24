`ifndef AHB_SLAVE_LOCKED_SEQUENCE_SEQ_INCLUDE_
`define AHB_SLAVE_LOCKED_SEQUENCE_SEQ_INCLUDE_

class ahb_slave_locked_sequence_seq extends ahb_slave_base_seq;
    `uvm_object_utils(ahb_slave_locked_sequence_seq)

    extern function new(string name = "ahb_slave_locked_sequence_seq",uvm_component parent=null);
    extern task body();
endclass : ahb_slave_locked_sequence_seq
function ahb_slave_locked_sequence_seq::new(string name = "ahb_slave_locked_sequence_seq",uvm_component parent=null);
    super.new(name,parent);
endfunction : new

task ahb_slave_locked_sequence_seq::body();
    super.body();
    start_item(req_m);
    if(!req_m.randomize()) begin
        `uvm_fatal("ahb_slave","Rand failed");
    end
    finish_item(req_m);
endtask : body
`endif
