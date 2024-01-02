//Uvm tests for {{name|replace('_tb','')}}
package {{name|replace('_tb','')}}_test_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import autb_generic_agent_pkg::*;
    import autb_csr_agent_pkg::*;
    //import observer_real_pkg::*;
    import {{name|replace('_tb','')}}_env_pkg::*;
    import {{name|replace('_tb','')}}_power_seq_lib_pkg::*;
    import {{name|replace('_tb','')}}_bias_seq_lib_pkg::*;
    import {{name|replace('_tb','')}}_digital_seq_lib_pkg::*;
    import {{name|replace('_tb','')}}_register_seq_lib_pkg::*;
    import {{name|replace('_tb','')}}_analog_seq_lib_pkg::*;
    import {{name|replace('_tb','')}}_test_seq_lib_pkg::*;
    

    `include "{{name|replace('_tb','')}}_test_base.svh"
    `include "sanity_test.svh"

endpackage: {{name|replace('_tb','')}}_test_pkg