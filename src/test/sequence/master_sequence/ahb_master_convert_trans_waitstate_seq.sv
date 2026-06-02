`ifndef AHB_MASTER_CONVERT_TRANS_WAITSTATE_SEQ_INCLUDE_
`define AHB_MASTER_CONVERT_TRANS_WAITSTATE_SEQ_INCLUDE_

class ahb_master_convert_trans_waitstate_seq extends ahb_master_base_seq;
    `uvm_object_utils(ahb_master_convert_trans_waitstate_seq)

    extern function new(string name = "ahb_master_convert_trans_waitstate_seq");
    extern task body();
endclass : ahb_master_convert_trans_waitstate_seq

function ahb_master_convert_trans_waitstate_seq::new(string name = "ahb_master_convert_trans_waitstate_seq");
    super.new(name);
endfunction : new

task ahb_master_convert_trans_waitstate_seq::body();
    bit has_convert_waitstate = 1;
   // Test converting transactions with wait states
   // Single transfer with 1 wait state
   do_burst_transfer(32'h2000_0000, HWRITE_WRITE, INCR4, HSIZE_WORD, 1,0,has_convert_waitstate);
   do_idle(1, 32'h2000_0000);
   
   // Burst with 2 wait states
   do_burst_transfer(32'h2000_0100, HWRITE_READ, INCR4, HSIZE_WORD,50,0,has_convert_waitstate);
   do_idle(2, 32'h2000_0100);
   
   do_burst_transfer(32'h2000_0100, HWRITE_WRITE, INCR, HSIZE_WORD,50,3,has_convert_waitstate);
   do_idle(2, 32'h2000_0100);
   do_burst_transfer(32'h2000_0100, HWRITE_WRITE, INCR, HSIZE_WORD,0,2,has_convert_waitstate);
    start_item(req_m);
    assert(req_m.randomize() with {
      req_m.htrans == HTRANS_BUSY;
      req_m.haddr == 32'h2000_0108;
      req_m.hburst == INCR;
      req_m.has_convert_waitstate == has_convert_waitstate;
    });
    finish_item(req_m);

    do_burst_transfer(32'h2000_0100, HWRITE_WRITE, INCR, HSIZE_WORD,0,2);
    start_item(req_m);
    assert(req_m.randomize() with {
      htrans == HTRANS_BUSY;
      req_m.haddr == 32'h2000_0108;
      hburst == INCR;
      req_m.has_convert_waitstate == has_convert_waitstate;
    });
    finish_item(req_m);
    do_idle(1, 32'h2000_0000);
endtask : body
`endif
