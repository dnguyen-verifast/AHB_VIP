`ifndef AHB_SLAVE_BASE_SEQ_INCLUDED_
`define AHB_SLAVE_BASE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: ahb_slave_base_seq 
// creating ahb_slave_base_seq class extends from uvm_sequence
//--------------------------------------------------------------------------------------------
class ahb_slave_base_seq extends uvm_sequence #(ahb_slave_tx);

  //factory registration
  `uvm_object_utils(ahb_slave_base_seq)
  
  //-------------------------------------------------------
  // Externally defined Function
  //-------------------------------------------------------
  extern function new(string name = "ahb_slave_base_seq");
   extern task body();
endclass : ahb_slave_base_seq

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the axi4_master_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function ahb_slave_base_seq::new(string name = "ahb_slave_base_seq");
  super.new(name);
endfunction : new

task ahb_master_base_seq::body();
  req_slv = ahb_slave_tx::type_id::create("req_slv",this);
endtask : body
`endif
