`ifndef AHB_DRIVER_AGENT_INCLUDE_
`define AHB_DRIVER_AGENT_INCLUDE_

class ahb_slave_driver extends uvm_driver#(ahb_slave_tx);
    `uvm_component_utils(ahb_slave_driver)

    uvm_seq_item_pull_port #(REQ,RSP) ahb_slave_seq_item_port;

    uvm_analysis_port #(RSP) ahb_write_rsp_port;

    REQ req_write, req_read;
    RSP rsp_write, rsp_read;

    virtual ahb_if ahb_if_h;

    
extern function new(string name = "ahb_slave_driver", uvm_component parent=null);
extern virtual function void build_phase(uvm_phase phase);
extern virtual function void end_of_elaboration_phase(uvm_phase phase);
extern virtual task run_phase(uvm_phase phase);

extern virtual task wr_addr_phase();
//extern virtual task wr_data_phase();

extern virtual task wait_ahb_for_resetn();

endclass : ahb_slave_driver

function ahb_slave_driver::new(string name="ahb_slave_driver",uvm_component parent=null);
    super.new(name,parent);
    ahb_slave_seq_item_port = new("ahb_slave_seq_item_port",this);
endfunction : new

function void ahb_slave_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual ahb_if)::get(this,"","ahb_if",ahb_if_h)) begin
        `uvm_fatal("DRIVER_MASTER","Fatal to get interface ahb_if");
    end
endfunction : build_phase

function void ahb_slave_driver::end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction : end_of_elaboration_phase

task ahb_slave_driver::run_phase(uvm_phase phase);
    `uvm_info("DRIVER_SLAVE", "Inside run_phase of AHB Driver master", UVM_LOW)

    wait_ahb_for_resetn();

    fork
        wr_addr_phase();
       // wr_data_phase();
    join

endtask : run_phase

task ahb_slave_driver::wait_ahb_for_resetn();
    @(negedge ahb_if_h.resetn);
    `uvm_info("DRIVER_SLAVE",$sformatf("SYSTEM RESET DETECTED"),UVM_HIGH)
    ahb_if_h.hrdata    <= '0;
    ahb_if_h.hreadyout <= '1;
    ahb_if_h.hresp     <= '0;
    ahb_if_h.hexokey   <= '0;
    @(posedge ahb_if_h.resetn);
    `uvm_info("DRIVER_SLAVE",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)
endtask : wait_ahb_for_resetn

task ahb_slave_driver::wr_addr_phase();
    forever begin
        ahb_slave_tx slv_tx_add;
        ahb_slave_tx slv_tx;
        ahb_transfer_struct slv_struct_add;
        ahb_transfer_struct slv_struct;
        ahb_slave_seq_item_port.get_next_item(slv_tx);
        ahb_slave_seq_item_converter::from_class(slv_tx,slv_struct);
        @(posedge ahb_if_h.clk)
        slv_struct_add.haddr     = ahb_if_h.haddr;
        slv_struct_add.hburst    = ahb_if_h.hburst;
        slv_struct_add.hmastlock = ahb_if_h.hmastlock;
        slv_struct_add.hprot     = ahb_if_h.hprot;
        slv_struct_add.hsize     = ahb_if_h.hsize;
        slv_struct_add.hnonsec   = ahb_if_h.hnonsec;
        slv_struct_add.hexcl     = ahb_if_h.hexcl;
        slv_struct_add.hmaster   = ahb_if_h.hmaster;
        slv_struct_add.htrans    = ahb_if_h.htrans;
        slv_struct_add.hwrite    = ahb_if_h.hwrite;
        ahb_slave_seq_item_converter::to_class(slv_struct_add,slv_tx_add);
        if(slv_tx_add.hwrite == HWRITE_WRITE) begin
            repeat(slv_tx_add.wait_state) begin
                `uvm_info("DRIVER_SLAVE","waiting for resolve a previous data phase",UVM_LOW)
                @(posedge ahb_if_h.clk);
                ahb_if_h.hreadyout <= 0;
            end
            if(slv_tx_add.hexcl == HEXCL_NORMAL) begin
                if(slv_tx_add.hresp == HRESP_ERROR) begin
                    ahb_if_h.hreadyout <= 0;
                    ahb_if_h.hresp     <= 1;
                    ahb_if_h.hexokey   <= 0;
                    @(posedge ahb_if_h.clk);
                    ahb_if_h.hreadyout <= 1;
                    ahb_if_h.hresp     <= 1;
                    ahb_if_h.hexokey   <= 0;
                end else begin
                    ahb_if_h.hreadyout <= 1;
                    ahb_if_h.hresp     <= 0;
                    slv_tx_add.hwdata   = ahb_if_h.hwdata;
                end
            end else if(slv_tx_add.hexcl == HEXCL_EXCLUSIVE) begin
               if(slv_tx_add.hexokey == HEXOKAY_PASS) begin
                    ahb_if_h.hreadyout <= 1;
                    ahb_if_h.hexokey     <= 1;
                    ahb_if_h.hresp     <= 0;
                    slv_tx_add.hwdata   = ahb_if_h.hwdata;
               end else begin
                    ahb_if_h.hreadyout <= 0;
                    ahb_if_h.hresp     <= 0;
                    ahb_if_h.hexokey   <= 0;
                    @(posedge ahb_if_h.clk);
                    ahb_if_h.hreadyout <= 1;
                    ahb_if_h.hresp     <= 0;
                    ahb_if_h.hexokey   <= 0;
               end
            end
        end else if(slv_tx_add.hwrite == HWRITE_READ) begin
            repeat(slv_tx_add.wait_state) begin
                `uvm_info("DRIVER_SLAVE","waiting for resolve a previous data phase",UVM_LOW)
                @(posedge ahb_if_h.clk);
                ahb_if_h.hreadyout <= 0;
            end
            if(slv_tx_add.hexcl == HEXCL_NORMAL) begin
                if(slv_tx_add.hresp == HRESP_ERROR) begin
                    ahb_if_h.hreadyout <= 0;
                    ahb_if_h.hresp     <= 1;
                    ahb_if_h.hexokey   <= 0;
                    @(posedge ahb_if_h.clk);
                    ahb_if_h.hreadyout <= 1;
                    ahb_if_h.hresp     <= 1;
                    ahb_if_h.hexokey   <= 0;
                    ahb_if_h.hrdata    <= slv_struct.hrdata;
                end else begin
                    ahb_if_h.hreadyout <= 1;
                    ahb_if_h.hresp     <= 0;
                    ahb_if_h.hrdata    <= slv_struct.hrdata;
                end
            end else if(slv_tx_add.hexcl == HEXCL_EXCLUSIVE) begin
               if(slv_tx_add.hexokey == HEXOKAY_PASS) begin
                    ahb_if_h.hreadyout <= 1;
                    ahb_if_h.hexokey   <= 1;
                    ahb_if_h.hresp     <= 0;
                    ahb_if_h.hrdata    <= slv_struct.hrdata;
               end else begin
                    ahb_if_h.hreadyout <= 0;
                    ahb_if_h.hresp     <= 0;
                    ahb_if_h.hexokey   <= 0;
                    @(posedge ahb_if_h.clk);
                    ahb_if_h.hreadyout <= 1;
                    ahb_if_h.hresp     <= 0;
                    ahb_if_h.hexokey   <= 0;
                    ahb_if_h.hrdata    <= slv_struct.hrdata;
               end
            end
        end
    end
endtask : wr_addr_phase
`endif


