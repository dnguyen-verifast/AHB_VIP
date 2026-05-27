`ifndef AHB_MASTER_TX_INCLUDE_
`define AHB_MASTER_TX_INCLUDE_
class ahb_master_tx extends ahb_base_tx;   
    `uvm_object_utils(ahb_master_tx)

    constraint haddr_c0 {soft haddr%(2**hsize)==0;}
    constraint hburst_c0 {soft hburst == SINGLE;}
    constraint hmastlock_c0 {soft hmastlock == 0;}
    constraint hprot_c0 {soft hprot ==0;}
    constraint hsize_c0 {soft 8*(2**hsize) <= DATA_WIDTH;}
    constraint hnonsec_c0 {soft hnonsec == 0;}
    constraint hexcl_c0 {soft hexcl == 0;}
    constraint hmaster_c0 {soft hmaster == 0;}
//    constraint htrans_c0 {soft htrans == HTRANS_IDLE;}
    constraint hsel_c0 {soft hsel == 1;}
    
endclass : ahb_master_tx
`endif