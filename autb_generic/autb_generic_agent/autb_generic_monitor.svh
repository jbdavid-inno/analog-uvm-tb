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
class autb_generic_monitor extends uvm_component;

    // UVM Factory Registration Macro
    //
    `uvm_component_utils(autb_generic_monitor)
    
    // Virtual Interface
    virtual autb_generic_if m_vif;
    
    //------------------------------------------
    // Data Members
    //------------------------------------------
    autb_generic_agent_config m_cfg;
      
    //------------------------------------------
    // Component Members
    //------------------------------------------
    uvm_analysis_port #(autb_generic_seq_item) ap;
    
    //------------------------------------------
    // Methods
    //------------------------------------------
    
    // Standard UVM Methods:
    
    extern function new(string name = "autb_generic_monitor", uvm_component parent = null);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern function void report_phase(uvm_phase phase);
    
    // Proxy Methods:
      
    extern function void notify_transaction(autb_generic_seq_item item);
      
    // Helper Methods:
    
  //  extern function void set_autb_generic_index(int index = 0);
      
    endclass: autb_generic_monitor
    
    function autb_generic_monitor::new(string name = "autb_generic_monitor", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    
    function void autb_generic_monitor::build_phase(uvm_phase phase);
	   if( !uvm_config_db#(autb_generic_agent_config)::get(this, "", "autb_generic_agent_config", m_cfg)) `uvm_error("build_phase", "unable to get config")
      //`get_config(autb_generic_agent_config, m_cfg, "autb_generic_agent_config")
      m_vif = m_cfg.m_vif;
      //`get_config(autb_generic_agent_config, m_cfg, "autb_generic_agent_config")
    //  m_bfm = m_cfg.mon_bfm;
    //  m_bfm.proxy = this;
    //  set_autb_generic_index(m_cfg.autb_generic_index);
      
      ap = new("ap", this);
    endfunction: build_phase
    
    task autb_generic_monitor::run_phase(uvm_phase phase);
       autb_generic_seq_item item;
	   autb_generic_seq_item cloned_item;
	    string index;
  		item = autb_generic_seq_item::type_id::create("item");
	    forever begin
		    	@(m_vif.sample_trigger);
		    	foreach (m_vif.observations[index]) item.observations[index] = m_vif.observations[index];
          item.design_state_name = m_vif.design_state_name;
		    	$cast(cloned_item, item.clone());
		    	notify_transaction(cloned_item);
	    end
     // m_bfm.run();
    endtask: run_phase
    
    function void autb_generic_monitor::report_phase(uvm_phase phase);
    // Might be a good place to do some reporting on no of analysis transactions sent etc
    
    endfunction: report_phase
    
    function void autb_generic_monitor::notify_transaction(autb_generic_seq_item item);
      ap.write(item);
    endfunction : notify_transaction
    
//    function void autb_generic_monitor::set_autb_generic_index(int index = 0);
//      m_bfm.autb_generic_index = index;
//    endfunction : set_autb_generic_index
    