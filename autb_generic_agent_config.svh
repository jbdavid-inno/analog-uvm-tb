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
class autb_generic_agent_config extends uvm_object;

    localparam string s_my_config_id = "autb_generic_agent_config";
    localparam string s_no_config_id = "no config";
    localparam string s_my_config_type_error_id = "config type error";
    
    // UVM Factory Registration Macro
    //
    `uvm_object_utils(autb_generic_agent_config)
    
    // BFM Virtual Interfaces

    virtual autb_generic_if  m_vif;
    
    //------------------------------------------
    // Data Members
    //------------------------------------------
    // Is the agent active or passive
    uvm_active_passive_enum active = UVM_PASSIVE;
    // Include the APB functional coverage monitor
    bit has_functional_coverage = 0;
    // Include the APB RAM based scoreboard
    bit has_scoreboard = 0;
    //
    // Address decode for the select lines:
    
    //------------------------------------------
    // Methods
    //------------------------------------------
    extern static function autb_generic_agent_config get_config( uvm_component c );
    // Standard UVM Methods:
    extern function new(string name = "autb_generic_agent_config");
    
    endclass: autb_generic_agent_config
    
    function autb_generic_agent_config::new(string name = "autb_generic_agent_config");
      super.new(name);
    endfunction
    
    //
    // Function: get_config
    //
    // This method gets the my_config associated with component c. We check for
    // the two kinds of error which may occur with this kind of
    // operation.
    //
    function autb_generic_agent_config autb_generic_agent_config::get_config( uvm_component c );
      autb_generic_agent_config t;
    
      if (!uvm_config_db #(autb_generic_agent_config)::get(c, "", s_my_config_id, t) )
         `uvm_fatal("CONFIG_LOAD", $sformatf("Cannot get() configuration %s from uvm_config_db. Have you set() it?", s_my_config_id))
    
      return t;
    endfunction
    