`ifndef AHB_TEST_BASE_INCLUDED_
`define AHB_TEST_BASE_INCLUDED_

class ahb_test_base extends uvm_test;
    `uvm_component_utils(ahb_test_base)

    ahb_env ahb_env_h;
    

    extern function new(string name = "ahb_test_base", uvm_component parent = null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void end_of_elaboration_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
endclass : ahb_test_base

function ahb_test_base::new(string name = "ahb_test_base",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void ahb_test_base::build_phase(uvm_phase phase);
  super.build_phase(phase);
  ahb_env_h = ahb_env::type_id::create("ahb_env_h",this);
endfunction : build_phase

function void ahb_test_base::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
 // uvm_test_done.set_drain_time(this,100ns);
endfunction : end_of_elaboration_phase

task ahb_test_base::run_phase(uvm_phase phase);
  phase.raise_objection(this, "ahb_test_base");
  `uvm_info(get_type_name(), $sformatf("Inside BASE_TEST"), UVM_NONE);
  super.run_phase(phase);
  #100;
  `uvm_info(get_type_name(), $sformatf("Done BASE_TEST"), UVM_NONE);
  phase.drop_objection(this);
endtask : run_phase
`endif