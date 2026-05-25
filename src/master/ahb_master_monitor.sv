`ifndef AHB_MASTER_MONITOR_INCLUDE_
`define AHB_MASTER_MONITOR_INCLUDE_

class ahb_master_monitor extends uvm_monitor;
    `uvm_component_utils(ahb_master_monitor)

    virtual ahb_if ahb_if_h;

    uvm_analysis_port#(ahb_master_tx)  ahb_master_data_analysis_port;
    uvm_analysis_port#(ahb_master_tx)  ahb_master_addr_analysis_port;

    extern function new(string name = "ahb_master_monitor", uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    extern virtual function void end_of_elaboration_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);

    extern virtual task ahb_master_data_phase();
    extern virtual task ahb_master_addr_phase(); 
endclass : ahb_master_monitor

function ahb_master_monitor::new(string name ="ahb_master_monitor", uvm_component parent =null);
    super.new(name, parent);
    ahb_master_data_analysis_port = new("ahb_master_data_analysis_port",this);
    ahb_master_addr_analysis_port = new("ahb_master_addr_analysis_port",this);
endfunction : new

function void ahb_master_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual ahb_if)::get(this,"","ahb_if",ahb_if_h)) begin
        `uvm_fatal("MONITOR_MASTER","Dont get interface ahb_if_h");
    end
endfunction :build_phase

function void ahb_master_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction : connect_phase

function void ahb_master_monitor::end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction: end_of_elaboration_phase

task ahb_master_monitor::run_phase(uvm_phase phase);
    @(negedge ahb_if_h.resetn);
    `uvm_info("FROM MASTER MON BFM",$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH) 
    @(posedge ahb_if_h.resetn);
    `uvm_info("FROM MASTER MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)

    fork
        ahb_master_data_phase();
        ahb_master_addr_phase(); 
    join
endtask : run_phase

task ahb_master_monitor::ahb_master_data_phase();
    forever begin
        ahb_master_tx m_tx_data;
        @(posedge ahb_if_h.clk);
        if(ahb_if_h.hready_out == 1) begin
             m_tx_data.hwdata  = ahb_if_h.hwdata;
             m_tx_data.hwstrb  = ahb_if_h.hwstrb ;
             m_tx_data.hresp   = ahb_if_h.hresp;
             m_tx_data.hrdata   = ahb_if_h.hrdata;
             m_tx_data.hexokey   = ahb_if_h.hexokey;  
        end
        ahb_master_data_analysis_port.write(m_tx_data);
    end
endtask : ahb_master_data_phase


task ahb_master_monitor::ahb_master_addr_phase();
    forever begin
        ahb_master_tx m_tx_add;
        @(posedge ahb_if_h.clk);
        if(ahb_if_h.hready_out == 1) begin
            m_tx_add.haddr     = ahb_if_h.haddr;
            m_tx_add.hburst    = ahb_if_h.hburst;
            m_tx_add.hmastlock = ahb_if_h.hmastlock;
            m_tx_add.hprot     = ahb_if_h.hprot;
            m_tx_add.hsize     = ahb_if_h.hsize;
            m_tx_add.hnonsec   = ahb_if_h.hnonsec;
            m_tx_add.hexcl     = ahb_if_h.hexcl;
            m_tx_add.hmaster   = ahb_if_h.hmaster;
            m_tx_add.htrans    = ahb_if_h.htrans;
            m_tx_add.hwrite    = ahb_if_h.hwrite;
        end
        ahb_master_addr_analysis_port.write(m_tx_add);
    end
endtask : ahb_master_addr_phase
`endif