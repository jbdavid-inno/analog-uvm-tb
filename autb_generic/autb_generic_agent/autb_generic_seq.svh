//------------------------------------------------------------
//
// Class Description: sequencer for generic item
//
//
class autb_generic_seq extends uvm_sequence #(autb_generic_seq_item);

    // UVM Factory Registration Macro
    //
    `uvm_object_utils(autb_generic_seq)
    
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
    extern function new(string name = "autb_generic_seq");
    extern task body;
    
    endclass:autb_generic_seq
    
    function autb_generic_seq::new(string name = "autb_generic_seq");
      super.new(name);
    endfunction
    
    task autb_generic_seq::body;
      autb_generic_seq_item req;
    
      begin
        req = autb_generic_seq_item::type_id::create("req");
        start_item(req);
        assert(req.randomize());
        finish_item(req);
      end
    
    endtask:body
    