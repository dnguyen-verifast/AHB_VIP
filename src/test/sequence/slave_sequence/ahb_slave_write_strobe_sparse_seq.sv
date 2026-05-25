`ifndef AHB_SLAVE_WRITE_STROBE_SPARSE_SEQ_INCLUDE_
`define AHB_SLAVE_WRITE_STROBE_SPARSE_SEQ_INCLUDE_

class ahb_slave_write_strobe_sparse_seq extends ahb_slave_base_seq;
    `uvm_object_utils(ahb_slave_write_strobe_sparse_seq)

    extern function new(string name = "ahb_slave_write_strobe_sparse_seq",uvm_component parent=null);
    extern task body();
endclass : ahb_slave_write_strobe_sparse_seq
function ahb_slave_write_strobe_sparse_seq::new(string name = "ahb_slave_write_strobe_sparse_seq",uvm_component parent=null);
    super.new(name,parent);
endfunction : new

task ahb_slave_write_strobe_sparse_seq::body();
    super.body();
    start_item(req_slv);
    if(!req_slv.randomize()) begin
        `uvm_fatal("ahb_slave","Rand failed");
    end
    finish_item(req_slv);
endtask : body
`endif
