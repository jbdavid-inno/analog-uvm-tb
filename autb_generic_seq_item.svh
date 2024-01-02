// sends control values to tb in name, value pairs in a hash  , with values converted to string for sending
class autb_generic_seq_item extends uvm_sequence_item;
    // UVM Factory Registration Macro
    `uvm_object_utils(autb_generic_seq_item)

    //------------------------------------------
    // Data Members - extend and add random vars, after randomization copy into the hash.  
    //------------------------------------------
    string settings[string];
    string observations[string];
    string design_state_name;
    
    // Standard UVM Methods:
    extern function new(string name = "autb_generic_seq_item");
    extern function void do_copy(uvm_object rhs);
    extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    extern function string convert2string();
    extern function void do_print(uvm_printer printer);
    extern function void do_record(uvm_recorder recorder);
    
endclass:autb_generic_seq_item

  function autb_generic_seq_item::new(string name = "autb_generic_seq_item");
    super.new(name);
  endfunction
  
  function void autb_generic_seq_item::do_copy(uvm_object rhs);
    autb_generic_seq_item rhs_;
    string i; 
    if(!$cast(rhs_, rhs)) begin
      `uvm_fatal("do_copy", "cast of rhs object failed")
    end
    super.do_copy(rhs);
    // Copy over data members:
    design_state_name = rhs_.design_state_name;
    foreach (rhs_.settings[i]) settings[i] = rhs_.settings[i];
    foreach (rhs_.observations[i]) observations[i] = rhs_.observations[i];

  
  endfunction:do_copy
  
  function bit autb_generic_seq_item::do_compare(uvm_object rhs, uvm_comparer comparer);
    autb_generic_seq_item rhs_;
  	string i;
	  bit eq = 1;
    if(!$cast(rhs_, rhs)) begin
      `uvm_error("do_copy", "cast of rhs object failed")
      return 0;
    end
    
    eq &=  super.do_compare(rhs, comparer);
    foreach (rhs_.settings[i])
        eq &= settings[i] == rhs_.settings[i];
    foreach (rhs_.observations[i])
        eq &= observations[i] == rhs_.observations[i];
    eq &= design_state_name == rhs_.design_state_name;
      
    return eq;
  endfunction:do_compare
  
  function string autb_generic_seq_item::convert2string();
    string s;
	string i;  
    $sformat(s, "%s\n", super.convert2string());
    $sformat(s, "%s\n design_state_name\t=\t%s\n", s, design_state_name  );
    foreach (settings[i]) // Convert to string function reusing s:
    	$sformat(s, "%s\n settings[%s]\t=\t%s\n", s, i, settings[i] );
    foreach (observations[i]) // Convert to string function reusing s:
    	$sformat(s, "%s\n observations[%s]\t=\t%s\n", s, i, observations[i] );
    return s;
  
  endfunction:convert2string
  
function void autb_generic_seq_item::do_print(uvm_printer printer);
  printer.m_string = convert2string();
endfunction:do_print

function void autb_generic_seq_item:: do_record(uvm_recorder recorder);
  string i;
  super.do_record(recorder);
  // Use the record macros to record the item fields:
      `uvm_record_field("design_state_name",design_state_name )
      foreach (settings[i]) // Convert to string function reusing s:
  		`uvm_record_field({"settings[",i,"]"},settings[i])
      foreach (settings[i]) // Convert to string function reusing s:
  		`uvm_record_field({"observations[",i,"]"},observations[i])
endfunction:do_record
