`ifndef AHB_VIRTUAL_SEQUENCE_PKG_INCLUDED_
`define AHB_VIRTUAL_SEQUENCE_PKG_INCLUDED_

package ahb_virtual_sequence_pkg;

    import uvm_pkg::*;
    import ahb_global_pkg::*;
    import ahb_base_pkg::*;
    import ahb_master_sequence_pkg::*;
    import ahb_slave_sequence_pkg::*;
    import ahb_env_pkg::*;

    `include "uvm_macros.svh"

    `include "ahb_virtual_base_seq.sv"
    `include "ahb_virtual_basic_single_rw_seq.sv"
    `include "ahb_virtual_idle_transfer_seq.sv"
    `include "ahb_virtual_fixed_incr_burst_seq.sv"
    `include "ahb_virtual_wrap_burst_seq.sv"
    `include "ahb_virtual_busy_burst_seq.sv"
    `include "ahb_virtual_1kb_boundary_violation_seq.sv"
    `include "ahb_virtual_random_wait_state_seq.sv"
    `include "ahb_virtual_manager_signal_stability_seq.sv"
    `include "ahb_virtual_error_response_seq.sv"
    `include "ahb_virtual_locked_sequence_seq.sv"
    `include "ahb_virtual_write_strobe_sparse_seq.sv"
    `include "ahb_virtual_exclusive_access_seq.sv"
    `include "ahb_virtual_parity_error_injection_seq.sv"

endpackage : ahb_virtual_sequence_pkg

`endif // AHB_VIRTUAL_SEQUENCE_PKG_INCLUDED_
