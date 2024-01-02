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
class autb_csr_driver extends uvm_driver #(autb_csr_seq_item, autb_csr_seq_item);

    // UVM Factory Registration Macro
    //
    `uvm_component_utils(autb_csr_driver)
    
    // Virtual Interface
    virtual autb_csr_if m_vif;
    
    //------------------------------------------
    // Data Members
    //------------------------------------------
    autb_csr_agent_config m_cfg;
      
    //------------------------------------------
    // Methods
    //------------------------------------------
    // Standard UVM Methods:
    extern function new(string name = "autb_csr_driver", uvm_component parent = null);
    extern task run_phase(uvm_phase phase);
    extern function void build_phase(uvm_phase phase);
    
    endclass: autb_csr_driver
    
    function autb_csr_driver::new(string name = "autb_csr_driver", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    
    function void autb_csr_driver::build_phase(uvm_phase phase);
      super.build_phase(phase);
	   if( !uvm_config_db#(autb_csr_agent_config)::get(this, "", "autb_csr_agent_config", m_cfg)) `uvm_error("build_phase", "unable to get config")
      //`get_config(autb_csr_agent_config, m_cfg, "autb_csr_agent_config")
      m_vif = m_cfg.m_vif;
    endfunction: build_phase
    
    task autb_csr_driver::run_phase(uvm_phase phase);
      autb_csr_seq_item req;
      autb_csr_seq_item rsp;
      int psel_index;
      string setting;
      int delay_us;
      //m_bfm.m_cfg = m_cfg;
      forever
       begin
      
         seq_item_port.get_next_item(req);
         `uvm_info("AUTB_CSR_DRIVER",$sformatf("Starting sequence %s", req.get_name() ),UVM_LOW)
         foreach (req.writable[setting]) m_vif.writable[setting] = req.writable[setting];
         m_vif.sequence_name = req.get_name();// for plotting purpose
         //delay_us = req.delay_us;
         if (req.delay_us) m_vif.delay(.us_delay(req.delay_us));  // task call returns once delay is finished.
         // while split tb idea suggests to push this to the IF ... there is no hardware acceleration available for analog yet. .. split it later
         // on the otherhand easier to plot things in the interface

         //while (delay_us) #1us delay_us--;
         seq_item_port.item_done();
       end
    
    endtask: run_phase
    