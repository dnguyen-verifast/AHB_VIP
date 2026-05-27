`ifndef AHB_SLAVE_BASIC_SINGLE_RW_SEQ_INCLUDE_
`define AHB_SLAVE_BASIC_SINGLE_RW_SEQ_INCLUDE_

class ahb_slave_basic_single_rw_seq extends ahb_slave_base_seq;
    `uvm_object_utils(ahb_slave_basic_single_rw_seq)

    extern function new(string name = "ahb_slave_basic_single_rw_seq");
    extern task body();
endclass : ahb_slave_basic_single_rw_seq
function ahb_slave_basic_single_rw_seq::new(string name = "ahb_slave_basic_single_rw_seq");
    super.new(name);
endfunction : new

task ahb_slave_basic_single_rw_seq::body();
    super.body();
    start_item(req_slv);
    if(!req_slv.randomize() with {
        hresp == HRESP_OKAY;
        wait_state == 0;
        
    }) 
    begin
        `uvm_fatal("ahb_slave","Rand failed");
    end
    finish_item(req_slv);
endtask : body
`endif