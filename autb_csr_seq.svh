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
class autb_csr_seq extends uvm_sequence #(autb_csr_seq_item);

    // UVM Factory Registration Macro
    //
    `uvm_object_utils(autb_csr_seq)
    
    //------------------------------------------
    // Data Members (Outputs rand, inputs non-rand)
    //------------------------------------------
    
    
    //------------------------------------------
    // Constraints
    //------------------------------------------
    
    
    
    //------------------------------------------
    // Methods
    //------------------------------------------
    
    // Standard UVM Methods:
    extern function new(string name = "autb_csr_seq");
    extern task body;
    
    endclass:autb_csr_seq
    
    function autb_csr_seq::new(string name = "autb_csr_seq");
      super.new(name);
    endfunction
    
    task autb_csr_seq::body;
      autb_csr_seq_item req;
    
      begin
        req = autb_csr_seq_item::type_id::create("req");
        start_item(req);
        assert(req.randomize());
        finish_item(req);
      end
    
    endtask:body
    