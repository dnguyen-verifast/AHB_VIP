`ifndef AHB_BASE_TX_INCLUDE_
`define AHB_BASE_TX_INCLUDE_

class ahb_base_tx extends uvm_sequence_item;
    `uvm_object_utils(ahb_base_tx)
    rand bit [ADDR_WIDTH-1 : 0]    haddr;
    rand hburst_e                    hburst;
    rand bit                          hmastlock;
    rand hprot_e                    hprot;
    rand hsize_e                    hsize;
    rand bit                        hnonsec;
    rand bit                          hexcl;
    rand hmaster_e                  hmaster;
    rand htrans_e                   htrans;
    rand bit [DATA_WIDTH-1:0]      hwdata;
    rand bit [HWSTRB-1:0]          hwstrb;
    rand bit                       hwrite;
    
    rand bit [DATA_WIDTH-1:0]      hrdata;
    rand bit                        hreadyout;
    rand bit                        hresp;
    rand bit                        hexokey;
    
    rand bit                        hsel;

    rand bit [2:0]                  wait_state;
    extern function new(string name = "ahb_base_tx");
    extern function void do_copy(uvm_object rhs);
    extern function void do_print(uvm_printer printer);
    extern function bit do_compare(uvm_object rhs,uvm_comparer comparer);
endclass : ahb_base_tx
function void ahb_base_tx::do_copy(uvm_object rhs);
    ahb_base_tx ahb_base_tx_copy;
    if(!$cast(ahb_base_tx_copy,rhs)) begin
       `uvm_fatal("do_copy", "cast failed") 
    end
    super.do_copy(rsh);
    haddr = ahb_base_tx_copy.haddr;
    hburst = ahb_base_tx_copy.hburst;
    hmastlock = ahb_base_tx_copy.hmastlock;
    hprot = ahb_base_tx_copy.hprot;
    hsize = ahb_base_tx_copy.hsize;
    hnonsec = ahb_base_tx_copy.hnonsec;
    hexcl = ahb_base_tx_copy.hexcl;
    hmaster = ahb_base_tx_copy.hmaster;
    htrans = ahb_base_tx_copy.htrans;
    hwdata = ahb_base_tx_copy.hwdata;
    hwstrb = ahb_base_tx_copy.hwstrb;
    hwrite = ahb_base_tx_copy.hwrite;

    hrdata = ahb_base_tx_copy.hrdata;
    hreadyout = ahb_base_tx_copy.hreadyout;
    hresp = ahb_base_tx_copy.hresp;
    hexokey = ahb_base_tx_copy.hexokey;

    hsel = ahb_base_tx_copy.hsel;
endfunction : do_copy
function void do_print(uvm_printer printer);
   printer.print_feild("haddr",haddr,$bits(haddr),UVM_HEX);
   printer.print_string("hburst",hburst.name());
   printer.print_string("hmastlock",hmastlock.name());
   printer.print_string("hprot",hprot.name());
   printer.print_string("hsize",hsize.name());
   printer.print_string("hnonsec",hnonsec.name());
   printer.print_string("hexcl",hexcl.name());
   printer.print_string("hmaster",hmaster.name());
   printer.print_string("htrans",htrans.name());
   printer.print_feild("hwdata",hwdata,$bits(hwdata),UVM_HEX);
   printer.print_feild("hwstrb",hwstrb,$bits(hwstrb),UVM_BIN);
   printer.print_string("hwrite",hwrite.name());
   printer.print_string("hsel",hsel.name());
   printer.print_string("hresp",hresp.name());
   printer.print_feild("hrdata",hrdata,$bits(hrdata),UVM_HEX);
   printer.print_feild("hreadyout",hreadyout,$bits(hreadyout),UVM_BIN);
   printer.print_string("hexokey",hexokey.name());
endfunction
function void do_compare(uvm_object rhs,uvm_comparer comparer);
    ahb_base_tx ahb_base_tx_comparer;
    bit result;
    if(rhs == null) begin
        `uvm_warning("COMPARER","Comparer object null !!")
    end
    if(!$cast(ahb_base_tx_comparer,rhs)) begin
        `uvm_fatal("FATAL_AHB_BASE_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
        return 0;
    end
    result = 1;
    // result = super.do_compare(axi4_base_tx_compare_obj, comparer);
    result &= (haddr     == ahb_base_tx_comparer.haddr)     &&
           (hburst    == ahb_base_tx_comparer.hburst)    &&
           (hmastlock == ahb_base_tx_comparer.hmastlock) &&
           (hprot     == ahb_base_tx_comparer.hprot)     &&
           (hsize     == ahb_base_tx_comparer.hsize)     &&
           (hnonsec   == ahb_base_tx_comparer.hnonsec)   &&
           (hexcl     == ahb_base_tx_comparer.hexcl)     &&
           (hmaster   == ahb_base_tx_comparer.hmaster)   &&
           (htrans    == ahb_base_tx_comparer.htrans)    &&
           (hwdata    == ahb_base_tx_comparer.hwdata)    &&
           (hwstrb    == ahb_base_tx_comparer.hwstrb)    &&
           (hwrite    == ahb_base_tx_comparer.hwrite)    &&
           (hrdata    == ahb_base_tx_comparer.hrdata)    &&
           (hreadyout == ahb_base_tx_comparer.hreadyout) &&
           (hresp     == ahb_base_tx_comparer.hresp)     &&
           (hexokey   == ahb_base_tx_comparer.hexokey)   &&
           (hsel      == ahb_base_tx_comparer.hsel);
endfunction : do_compare
`endif 