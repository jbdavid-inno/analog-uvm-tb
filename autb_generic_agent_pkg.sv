package autb_generic_agent_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
//    `include "config_macro.svh"
    
    `include "autb_generic_seq_item.svh"
    `include "autb_generic_agent_config.svh"
    `include "autb_generic_driver.svh"
    `include "autb_generic_coverage_monitor.svh"
    `include "autb_generic_monitor.svh"
    typedef uvm_sequencer#(autb_generic_seq_item) autb_generic_sequencer;
    `include "autb_generic_agent.svh"
    
       
    // Utility Sequences
    `include "autb_generic_seq.svh"
    //`include "autb_generic_setcontrol_seq.svh"
    //`include "autb_generic_getstatus_seq.svh"
    
    endpackage: autb_generic_agent_pkg
    