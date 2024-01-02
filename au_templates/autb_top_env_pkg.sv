//
// Package Description:
//
package {{name[:-3]}}_env_pkg;

    // Standard UVM import & include:
    import uvm_pkg::*;
  `include "uvm_macros.svh"
  
    // Any further package imports:
    import autb_generic_agent_pkg::*;
    import autb_csr_agent_pkg::*;
   // import observer_real_pkg::*;
    
    // Includes:
  `include "{{name[:-3]}}_env_config.svh"
  `include "{{name[:-3]}}_scoreboard.svh"
  `include "{{name[:-3]}}_vsequencer.svh"
  `include "{{name[:-3]}}_env.svh"
  
  endpackage: {{name[:-3]}}_env_pkg
  