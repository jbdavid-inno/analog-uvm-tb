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
class autb_generic_agent extends uvm_component;

    // UVM Factory Registration Macro
    //
    `uvm_component_utils(autb_generic_agent)
    
    //------------------------------------------
    // Data Members
    //------------------------------------------
    autb_generic_agent_config m_cfg;
    //------------------------------------------
    // Component Members
    //------------------------------------------
    uvm_analysis_port #(autb_generic_seq_item) ap;
    autb_generic_monitor   m_monitor;
    autb_generic_sequencer m_sequencer;
    autb_generic_driver    m_driver;
    autb_generic_coverage_monitor m_fcov_monitor;
    //------------------------------------------
    // Methods
    //------------------------------------------
    
    // Standard UVM Methods:
    extern function new(string name = "autb_generic_agent", uvm_component parent = null);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    
    endclass: autb_generic_agent
    
    
    function autb_generic_agent::new(string name = "autb_generic_agent", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    
    function void autb_generic_agent::build_phase(uvm_phase phase);
     // `get_config(autb_generic_agent_config, m_cfg, "autb_generic_agent_config")
     	   if( !uvm_config_db#(autb_generic_agent_config)::get(this, "", "autb_generic_agent_config", m_cfg)) `uvm_error("build_phase", "unable to get config")
      // Monitor is always present
      m_monitor = autb_generic_monitor::type_id::create("m_monitor", this);
      m_monitor.m_cfg = m_cfg;
      // Only build the driver and sequencer if active
      if(m_cfg.active == UVM_ACTIVE) begin
        m_driver = autb_generic_driver::type_id::create("m_driver", this);
        m_driver.m_cfg = m_cfg;
        m_sequencer = autb_generic_sequencer::type_id::create("m_sequencer", this);
      end
      if(m_cfg.has_functional_coverage) begin
        m_fcov_monitor = autb_generic_coverage_monitor::type_id::create("m_fcov_monitor", this);
      end
    endfunction: build_phase
    
    function void autb_generic_agent::connect_phase(uvm_phase phase);
      ap = m_monitor.ap;
      // Only connect the driver and the sequencer if active
      if(m_cfg.active == UVM_ACTIVE) begin
        m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
      end
      if(m_cfg.has_functional_coverage) begin
        m_monitor.ap.connect(m_fcov_monitor.analysis_export);
      end
    
    endfunction: connect_phase
    