`ifndef AHB_VIRTUAL_BASIC_SINGLE_RW_REQ_INCLUDE_
`define AHB_VIRTUAL_BASIC_SINGLE_RW_REQ_INCLUDE_

class ahb_virtual_basic_single_rw_seq extends ahb_virtual_base_seq;
    `uvm_object_utils(ahb_virtual_basic_single_rw_seq)
    ahb_master_basic_single_rw_seq ahb_master_basic_single_rw_seq_h;
    ahb_slave_basic_single_rw_seq ahb_slave_basic_single_rw_seq_h;


    extern function new(string name = "ahb_virtual_basic_single_rw_seq");
    extern task body();
endclass : ahb_virtual_basic_single_rw_seq

task ahb_virtual_basic_single_rw_seq::body();
    ahb_master_basic_single_rw_seq_h = ahb_master_basic_single_rw_seq::type_id::create("ahb_master_basic_single_rw_seq_h");

    ahb_slave_basic_single_rw_seq_h = ahb_slave_basic_single_rw_seq::type_id::create("ahb_slave_basic_single_rw_seq_h");

    `uvm_info(get_type_name(), $sformatf("DEBUG_MSHA :: Insdie ahb_virtual_basic_single_rw_seq"), UVM_NONE); 

    fork 
        begin : T1_SL_WR
        forever begin
            ahb_slave_basic_single_rw_seq_h.start(p_sequencer.ahb_master_sequencer_h);
        end
        end
    join_none

    fork 
        begin: T1_WRITE
        repeat(2) begin
            ahb_master_basic_single_rw_seq_h.start(p_sequencer.ahb_master_sequencer_h);
        end
        end
        join
endtask : body
`endifv    