`ifndef AHB_MASTER_BASIC_SINGLE_BURST_SEQ_INCLUDE_
`define AHB_MASTER_BASIC_SINGLE_BURST_SEQ_INCLUDE_

class ahb_master_basic_single_burst_seq extends ahb_master_base_seq;
    `uvm_object_utils(ahb_master_basic_single_burst_seq)

    extern function new(string name = "ahb_master_basic_single_burst_seq");
    extern task body();
endclass : ahb_master_basic_single_burst_seq

function ahb_master_basic_single_burst_seq::new(string name = "ahb_master_basic_single_burst_seq");
    super.new(name);
endfunction : new

task ahb_master_basic_single_burst_seq::body();
   // INCR4 burst - Write
   do_burst_transfer(32'h3000_0000, HWRITE_WRITE, INCR4, HSIZE_WORD, 0);
   do_idle(2, 32'h3000_0010);
   
   // INCR4 burst - Read
   do_burst_transfer(32'h3000_0010, HWRITE_READ, INCR4, HSIZE_WORD, 0);
   do_idle(2, 32'h3000_0020);
   
   // WRAP4 burst - Write
   do_burst_transfer(32'h3000_0020, HWRITE_WRITE, WRAP4, HSIZE_WORD, 0);
   do_idle(2, 32'h3000_0020);
   
   // INCR8 burst - Read
   do_burst_transfer(32'h3000_0030, HWRITE_READ, INCR8, HSIZE_WORD, 0);
   do_idle(2, 32'h3000_0050);

endtask : body

`endif
