`ifndef AHB_ENV_INCLUDED_
`define AHB_ENV_INCLUDED_

class ahb_env extends uvm_env;
  `uvm_component_utils(ahb_env)

    ahb_master_agent ahb_master_agent_h;
    ahb_slave_agent ahb_slave_agent_h;
    ahb_scoreboard ahb_scoreboard_h;

    ahb_virtual_seqr ahb_virtual_seqr_h;

    extern function new(string name = "ahb_env", uvm_component parent = null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
endclass : ahb_env

function ahb_env::new(string name = "ahb_env", uvm_component parent = null);
      super.new(name, parent);
endfunction : new
function void ahb_env::build_phase(uvm_phase phase);
    super.build_phase(phase);
    ahb_master_agent_h = ahb_master_agent::type_id::create("ahb_master_agent_h",this);
    ahb_slave_agent_h = ahb_slave_agent::type_id::create("ahb_slave_agent_h",this);
    ahb_scoreboard_h = ahb_scoreboard::type_id::create("ahb_scoreboard_h",this);
    ahb_virtual_seqr_h = ahb_virtual_seqr::type_id::create("ahb_virtual_seqr_h",this);
endfunction : build_phase

function void ahb_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    ahb_slave_agent_h.ahb_slave_sequencer_h = ahb_virtual_seqr_h.ahb_slave_sequencer;
    ahb_master_agent_h.ahb_master_sequencer_h = ahb_virtual_seqr_h.ahb_master_sequencer_h;

    ahb_slave_agent_h.ahb_slave_monitor_h.ahb_slave_data_analysis_port.connect(ahb_scoreboard_h.ahb_slave_data_phase_analysis_fifo.analysis_export);
    ahb_slave_agent_h.ahb_slave_monitor_h.ahb_slave_addr_analysis_port.connect(ahb_scoreboard_h.ahb_slave_addr_phase_analysis_fifo.analysis_export);

    ahb_master_agent_h.ahb_master_monitor_h.ahb_master_data_analysis_port.connect(ahb_scoreboard_h.ahb_master_data_phase_analysis_fifo.analysis_export);
    ahb_master_agent_h.ahb_master_monitor_h.ahb_master_addr_analysis_port.connect(ahb_scoreboard_h.ahb_master_addr_phase_analysis_fifo.analysis_export);
endfunction : connect_phase

`endif