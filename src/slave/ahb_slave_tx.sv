`ifndef  AHB_SLAVE_TX_INCLUDE_
`define AHB_SLAVE_TX_INCLUDE_
class ahb_slave_tx extends ahb_base_tx;
    `uvm_object_utils(ahb_slave_tx)
    constraint hresp_c0 {if(htrans == IDLE) hresp == OKAY;}
    constraint wait_state_c0 {if(htrans == BUSY) wait_state == 0;}
    constraint hexokey_c0 {soft hexokey == EXOKAY;}
    constraint hrdata_c0 {soft hrdata > 0;}
endclass : ahb_slave_tx
`endif