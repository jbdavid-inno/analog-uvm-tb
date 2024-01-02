//------------------------------------------------------------
//
// Class Description:
//
//
class {{name[:-3]}}_env_config extends uvm_object;

    localparam string s_my_config_id = "{{name[:-3]}}_env_config";
    localparam string s_no_config_id = "no config";
    localparam string s_my_config_type_error_id = "config type error";
  
    // UVM Factory Registration Macro
    //
    `uvm_object_utils({{name[:-3]}}_env_config)
  
    // Interrupt Utility - used in the wait for interrupt task
    // 
  //  intr_util INTR;
    // observer utilities 
    // FVCO_OBSERVER - used in the VCO Ccoarse calibration task
    //observer_real_util FVCO_OBSERVER;
  
    //------------------------------------------
    // Data Members
    //------------------------------------------
    // Whether env analysis components are used:
    bit has_functional_coverage = 0;
    bit has_{{name[:-3]}}_functional_coverage = 1;
    bit has_reg_scoreboard = 0;
    //bit has_{{name[:-3]}}_scoreboard = 0;
  
    // Configurations for the sub_components
    autb_generic_agent_config m_analog_agent_cfg;
    autb_generic_agent_config m_bias_agent_cfg;
    autb_generic_agent_config m_digital_agent_cfg;
    autb_generic_agent_config m_power_agent_cfg;
    autb_csr_agent_config m_register_agent_cfg;
    
  
    // SPI Register block
    //{{name[:-3]}}_reg_block {{name[:-3]}}_rb;
  
    //------------------------------------------
    // Methods
    //------------------------------------------
    extern static function {{name[:-3]}}_env_config get_config( uvm_component c);
      //extern task wait_for_interrupt;
    //extern function bit is_vco_freq_above_target(input real vco_target_freq);
    // Standard UVM Methods:
    extern function new(string name = "{{name[:-3]}}_env_config");
  
  endclass: {{name[:-3]}}_env_config
  
  function {{name[:-3]}}_env_config::new(string name = "{{name[:-3]}}_env_config");
    super.new(name);
  endfunction
  
  //
  // Function: get_config
  //
  // This method gets the my_config associated with component c. We check for
  // the two kinds of error which may occur with this kind of
  // operation.
  //
  function {{name[:-3]}}_env_config {{name[:-3]}}_env_config::get_config( uvm_component c );
    {{name[:-3]}}_env_config t;
  
    if (!uvm_config_db #({{name[:-3]}}_env_config)::get(c, "", s_my_config_id, t) )
      `uvm_fatal("CONFIG_LOAD", $sformatf("Cannot get() configuration %s from uvm_config_db. Have you set() it?", s_my_config_id))
  
    return t;
  endfunction
  //function bit {{name[:-3]}}_env_config::is_vco_freq_above_target(input real vco_target_freq);
  //  return FVCO_OBSERVER.is_above_abs(vco_target_freq);
  //endfunction