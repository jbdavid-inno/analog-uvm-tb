//------------------------------------------------------------
//
// Class Description: driver for the AUTB generic agent
//
//
class autb_generic_driver extends uvm_driver #(autb_generic_seq_item, autb_generic_seq_item);

    // UVM Factory Registration Macro
    //
    `uvm_component_utils(autb_generic_driver)
    
    // Virtual Interface
    virtual autb_generic_if m_vif;
    
    //------------------------------------------
    // Data Members
    //------------------------------------------
    autb_generic_agent_config m_cfg;
      
    //------------------------------------------
    // Methods
    //------------------------------------------
    // Standard UVM Methods:
    extern function new(string name = "autb_generic_driver", uvm_component parent = null);
    extern task run_phase(uvm_phase phase);
    extern function void build_phase(uvm_phase phase);
    
endclass: autb_generic_driver
    
    function autb_generic_driver::new(string name = "autb_generic_driver", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    
    function void autb_generic_driver::build_phase(uvm_phase phase);
      super.build_phase(phase);
	   if( !uvm_config_db#(autb_generic_agent_config)::get(this, "", 
                                  "autb_generic_agent_config", m_cfg)) 
                                  `uvm_error("build_phase", "unable to get config")
      m_vif = m_cfg.m_vif;
    endfunction: build_phase
    
    task autb_generic_driver::run_phase(uvm_phase phase);
      autb_generic_seq_item req;
      autb_generic_seq_item rsp;
      int psel_index;
      string setting;
      forever
        begin  
          seq_item_port.get_next_item(req);
          `uvm_info($sformatf("%s_DRIVER",
            this.get_full_name().toupper()),
            $sformatf("Starting sequence %s", 
            req.get_name() ),UVM_LOW)
          foreach (req.settings[setting]) 
            m_vif.settings[setting] = req.settings[setting];
          m_vif.sequence_name = req.get_name();
          seq_item_port.item_done();
        end
    endtask: run_phase
    