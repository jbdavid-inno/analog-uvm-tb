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
class autb_csr_monitor extends uvm_component;

    // UVM Factory Registration Macro
    //
    `uvm_component_utils(autb_csr_monitor)
    
    // Virtual Interface
    virtual autb_csr_if m_vif;
    
    //------------------------------------------
    // Data Members
    //------------------------------------------
    autb_csr_agent_config m_cfg;
      
    //------------------------------------------
    // Component Members
    //------------------------------------------
    uvm_analysis_port #(autb_csr_seq_item) ap;
    
    //------------------------------------------
    // Methods
    //------------------------------------------
    
    // Standard UVM Methods:
    
    extern function new(string name = "autb_csr_monitor", uvm_component parent = null);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern function void report_phase(uvm_phase phase);
    
    // Proxy Methods:
      
    extern function void notify_transaction(autb_csr_seq_item item);
      
    // Helper Methods:
    
  //  extern function void set_autb_csr_index(int index = 0);
      
    endclass: autb_csr_monitor
    
    function autb_csr_monitor::new(string name = "autb_csr_monitor", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    
    function void autb_csr_monitor::build_phase(uvm_phase phase);
	   if( !uvm_config_db#(autb_csr_agent_config)::get(this, "", "autb_csr_agent_config", m_cfg)) `uvm_error("build_phase", "unable to get config")
      //`get_config(autb_csr_agent_config, m_cfg, "autb_csr_agent_config")
      m_vif = m_cfg.m_vif;
      //`get_config(autb_csr_agent_config, m_cfg, "autb_csr_agent_config")
    //  m_bfm = m_cfg.mon_bfm;
    //  m_bfm.proxy = this;
    //  set_autb_csr_index(m_cfg.autb_csr_index);
      
      ap = new("ap", this);
    endfunction: build_phase
    
    task autb_csr_monitor::run_phase(uvm_phase phase);
       autb_csr_seq_item item;
	   autb_csr_seq_item cloned_item;
	    string index;
  		item = autb_csr_seq_item::type_id::create("item");
	    forever begin
		    	@(m_vif.readonly["trigger"]);
		    	foreach (m_vif.readonly[index]) 
			    	if  (index != "trigger") item.readonly[index] = m_vif.readonly[index];
		    	$cast(cloned_item, item.clone());
		    	notify_transaction(cloned_item);
	    end
     // m_bfm.run();
    endtask: run_phase
    
    function void autb_csr_monitor::report_phase(uvm_phase phase);
    // Might be a good place to do some reporting on no of analysis transactions sent etc
    
    endfunction: report_phase
    
    function void autb_csr_monitor::notify_transaction(autb_csr_seq_item item);
      ap.write(item);
    endfunction : notify_transaction
    
//    function void autb_csr_monitor::set_autb_csr_index(int index = 0);
//      m_bfm.autb_csr_index = index;
//    endfunction : set_autb_csr_index
    