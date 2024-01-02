//------------------------------------------------------------
//   Copyright 2010-2018 Mentor Graphics Corporation
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//------------------------------------------------------------
//
// Class Description:
//
//
class {{name|replace('_tb','')}}_test_base extends uvm_test;

  // UVM Factory Registration Macro
  //
  `uvm_component_utils({{name|replace('_tb','')}}_test_base)

  //------------------------------------------
  // Data Members
  //------------------------------------------

  //------------------------------------------
  // Component Members
  //------------------------------------------
  // The environment class
  {{name|replace('_tb','')}}_env m_env;
  // Configuration objects
  {{name|replace('_tb','')}}_env_config m_env_cfg;
  autb_generic_agent_config m_analog_cfg;
  autb_generic_agent_config m_bias_cfg;
  autb_generic_agent_config m_digital_cfg;
  autb_generic_agent_config m_power_cfg;
  autb_csr_agent_config m_register_cfg;
  // observer utility
  //observer_real_util FVCO_OBSERVER;

  //------------------------------------------
  // Methods
  //------------------------------------------
  extern virtual function void configure_analog_agent(autb_generic_agent_config cfg);
  extern virtual function void configure_power_agent(autb_generic_agent_config cfg);
  extern virtual function void configure_bias_agent(autb_generic_agent_config cfg);
  extern virtual function void configure_digital_agent(autb_generic_agent_config cfg);
  extern virtual function void configure_register_agent(autb_csr_agent_config cfg);
  // Standard UVM Methods:
  extern function new(string name = "{{name|replace('_tb','')}}_test_base", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void set_seqs({{name|replace('_tb','')}}_vseq_base seq);
  extern function void start_of_simulation_phase(uvm_phase phase);
endclass: {{name|replace('_tb','')}}_test_base

function {{name|replace('_tb','')}}_test_base::new(string name = "{{name|replace('_tb','')}}_test_base", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build the env, create the env configuration
// including any sub configurations and assigning virtural interfaces
function void {{name|replace('_tb','')}}_test_base::build_phase(uvm_phase phase);
  virtual autb_generic_if    analog_vif;
  virtual autb_generic_if      bias_vif;
  virtual autb_generic_if   digital_vif;
  virtual autb_generic_if     power_vif;
  virtual autb_csr_if  register_vif;
 // virtual observer_real_if vco_freq_vif;
  // env configuration
  m_env_cfg = {{name|replace('_tb','')}}_env_config::type_id::create("m_env_cfg");
  // Register model
  // Enable all types of coverage available in the register model
  //uvm_reg::include_coverage("*", UVM_CVR_ALL);
  // Create the register model:
  //spi_rb = spi_reg_block::type_id::create("spi_rb");
  // Build and configure the register model
  //spi_rb.build();
  // Assign a handle to the register model in the env config
  //m_env_cfg.spi_rb = spi_rb;
  // APB configuration
  m_analog_cfg = autb_generic_agent_config::type_id::create("m_analog_cfg");
  configure_analog_agent(m_analog_cfg);
  if (!uvm_config_db #(virtual autb_generic_if)::get(this, "", "analog_vif", m_analog_cfg.m_vif))
    `uvm_fatal("VIF CONFIG", "Cannot get() Virt interface analog_vif from uvm_config_db. Have you set() it?")
  m_env_cfg.m_analog_agent_cfg = m_analog_cfg;

  m_bias_cfg = autb_generic_agent_config::type_id::create("m_bias_cfg");
  configure_bias_agent(m_bias_cfg);
  if (!uvm_config_db #(virtual autb_generic_if)::get(this, "", "bias_vif", m_bias_cfg.m_vif))
    `uvm_fatal("VIF CONFIG", "Cannot get() Virt interface bias_vif from uvm_config_db. Have you set() it?")
  m_env_cfg.m_bias_agent_cfg = m_bias_cfg;

  m_digital_cfg = autb_generic_agent_config::type_id::create("m_digital_cfg");
  configure_digital_agent(m_digital_cfg);
  if (!uvm_config_db #(virtual autb_generic_if)::get(this, "", "digital_vif", m_digital_cfg.m_vif))
    `uvm_fatal("VIF CONFIG", "Cannot get() Virt interface digital_vif from uvm_config_db. Have you set() it?")
  m_env_cfg.m_digital_agent_cfg = m_digital_cfg;

  m_power_cfg = autb_generic_agent_config::type_id::create("m_power_cfg");
  configure_power_agent(m_power_cfg);
  if (!uvm_config_db #(virtual autb_generic_if)::get(this, "", "power_vif", m_power_cfg.m_vif))
    `uvm_fatal("VIF CONFIG", "Cannot get() Virt interface power_vif from uvm_config_db. Have you set() it?")
  m_env_cfg.m_power_agent_cfg = m_power_cfg;

  m_register_cfg = autb_csr_agent_config::type_id::create("m_register_cfg");
  configure_register_agent(m_register_cfg);
  if (!uvm_config_db #(virtual autb_csr_if)::get(this, "", "register_vif", m_register_cfg.m_vif))
    `uvm_fatal("VIF CONFIG", "Cannot get() Virt interface register_vif from uvm_config_db. Have you set() it?")
  m_env_cfg.m_register_agent_cfg = m_register_cfg;
  ///////////////////////////////////////////////////////////////
  // insert observer/maniupulator virtual if into the env_config:
  ///////////////////////////////////////////////////////////////
  //FVCO_OBSERVER = observer_real_util::type_id::create("FVCO");
  //if (!uvm_config_db #(virtual observer_real_if)::get(this, "", "{{name}}_DUT_ilpll_core_u1_vco_I82_a_obs_Fosc__ILPLL_VCO_Fosc_obsvr_real_vif", vco_freq_vif))
  //  `uvm_fatal("VIF CONFIG", "Cannot get() Virt interface {{name}}_DUT_ilpll_core_u1_vco_I82_a_obs_Fosc__ILPLL_VCO_Fosc_obsvr_real_vif from uvm_config_db. Have you set() it?")
  //FVCO_OBSERVER.set_vif(vco_freq_vif);
  //m_env_cfg.FVCO_OBSERVER = FVCO_OBSERVER;


  uvm_config_db #({{name|replace('_tb','')}}_env_config)::set(this, "*", "{{name|replace('_tb','')}}_env_config", m_env_cfg);
  m_env = {{name|replace('_tb','')}}_env::type_id::create("m_env", this);
endfunction: build_phase

//
// Convenience function to configure the analog agent
//
// This can be overloaded by extensions to this test base class
function void {{name|replace('_tb','')}}_test_base::configure_analog_agent(autb_generic_agent_config cfg);
  cfg.active = {% if blocks['analog'].get('active')%}UVM_ACTIVE{%else%}UVM_PASSIVE{%endif%};
  cfg.has_functional_coverage = 0;
  cfg.has_scoreboard = 0;
endfunction: configure_analog_agent

//
// Convenience function to configure the bias agent
//
// This can be overloaded by extensions to this test base class
function void {{name|replace('_tb','')}}_test_base::configure_bias_agent(autb_generic_agent_config cfg);
  cfg.active = UVM_ACTIVE;
  cfg.has_functional_coverage = 0;
  cfg.has_scoreboard = 0;
endfunction: configure_bias_agent

//
// Convenience function to configure the digital agent
//
// This can be overloaded by extensions to this test base class
function void {{name|replace('_tb','')}}_test_base::configure_digital_agent(autb_generic_agent_config cfg);
  cfg.active = UVM_ACTIVE;
  cfg.has_functional_coverage = 0;
  cfg.has_scoreboard = 0;
endfunction: configure_digital_agent

//
// Convenience function to configure the power agent
//
// This can be overloaded by extensions to this test base class
function void {{name|replace('_tb','')}}_test_base::configure_power_agent(autb_generic_agent_config cfg);
  cfg.active = UVM_ACTIVE;
  cfg.has_functional_coverage = 0;
  cfg.has_scoreboard = 0;
endfunction: configure_power_agent

//
// Convenience function to configure the register agent
//
// This can be overloaded by extensions to this test base class
function void {{name|replace('_tb','')}}_test_base::configure_register_agent(autb_csr_agent_config cfg);
  cfg.active = UVM_ACTIVE;
  cfg.has_functional_coverage = 0;
  cfg.has_scoreboard = 0;
endfunction: configure_register_agent

function void {{name|replace('_tb','')}}_test_base::set_seqs({{name|replace('_tb','')}}_vseq_base seq);
  seq.m_cfg = m_env_cfg;

  //  seq.apb = m_env.m_apb_agent.m_sequencer;
  seq.analog_sqr = m_env.m_analog_agent.m_sequencer;
  seq.bias_sqr = m_env.m_bias_agent.m_sequencer;
  seq.digital_sqr = m_env.m_digital_agent.m_sequencer;
  seq.power_sqr = m_env.m_power_agent.m_sequencer;
  seq.register_sqr = m_env.m_register_agent.m_sequencer;
endfunction
function void {{name|replace('_tb','')}}_test_base::start_of_simulation_phase(uvm_phase phase);
  uvm_factory factory;
  super.start_of_simulation_phase(phase);
  if (uvm_report_enabled(UVM_HIGH)) begin
    factory = uvm_factory::get();
    this.print();
    factory.print();
  end
endfunction
