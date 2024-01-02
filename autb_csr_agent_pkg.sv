package autb_csr_agent_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
//    `include "config_macro.svh"
    
    `include "autb_csr_seq_item.svh"
    `include "autb_csr_agent_config.svh"
    `include "autb_csr_driver.svh"
    `include "autb_csr_coverage_monitor.svh"
    `include "autb_csr_monitor.svh"
    typedef uvm_sequencer#(autb_csr_seq_item) autb_csr_sequencer;
    `include "autb_csr_agent.svh"
    
       
    // Utility Sequences
    `include "autb_csr_seq.svh"
    //`include "autb_csr_setcontrol_seq.svh"
    //`include "autb_csr_getstatus_seq.svh"
    
    endpackage: autb_csr_agent_pkg