//`define uvm_record_field(NAME,VALUE) \
//  $add_attribute(recorder.get_handle(),VALUE,NAME);

// sends control values to tb in name, value pairs in a hash  , with values converted to string for sending
class autb_csr_seq_item extends uvm_sequence_item;
// UVM Factory Registration Macro
//
  `uvm_object_utils(autb_csr_seq_item)

  //------------------------------------------
  // Data Members (Outputs rand, inputs non-rand)
  //------------------------------------------
  int writable[string];
  int readonly[string];
  int delay_us;
  int delay_ns;
  string design_state_name;


  //------------------------------------------
  // Constraints
  //------------------------------------------

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name = "autb_csr_seq_item");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function string convert2string();
  extern function void do_print(uvm_printer printer);
  extern function void do_record(uvm_recorder recorder);

endclass:autb_csr_seq_item


function autb_csr_seq_item::new(string name = "autb_csr_seq_item");
  super.new(name);
endfunction

function void autb_csr_seq_item::do_copy(uvm_object rhs);
  autb_csr_seq_item rhs_;
  string i;
  if(!$cast(rhs_, rhs)) begin
    `uvm_fatal("do_copy", "cast of rhs object failed")
  end
  super.do_copy(rhs);
  // Copy over data members:
  design_state_name = rhs_.design_state_name;
  delay_us = rhs_.delay_us;
  delay_ns = rhs_.delay_ns;
  foreach (rhs_.writable[i]) writable[i] = rhs_.writable[i];
  foreach (rhs_.readonly[i]) readonly[i] = rhs_.readonly[i];


endfunction:do_copy

function bit autb_csr_seq_item::do_compare(uvm_object rhs, uvm_comparer comparer);
  autb_csr_seq_item rhs_;
  string i;
  bit eq = 1;
  if(!$cast(rhs_, rhs)) begin
    `uvm_error("do_copy", "cast of rhs object failed")
    return 0;
  end

  eq &=  super.do_compare(rhs, comparer);
  foreach (rhs_.writable[i])
    eq &= writable[i] == rhs_.writable[i];
  foreach (rhs_.readonly[i])
    eq &= readonly[i] == rhs_.readonly[i];
  eq &= design_state_name == rhs_.design_state_name; 
  eq &= delay_us == rhs_.delay_us;
  eq &= delay_ns == rhs_.delay_ns;

  return eq;
endfunction:do_compare

function string autb_csr_seq_item::convert2string();
  string s;
  string i;
  $sformat(s, "%s\n", super.convert2string());
  $sformat(s, "%s\ndesign_state\t=\t%s\n", s, design_state_name);
  $sformat(s, "%s\ndelay_us\t=\t%d\n", s, delay_us);
  $sformat(s, "%s\ndelay_ns\t=\t%d\n", s, delay_ns);
  foreach (writable[i]) // Convert to string function reusing s:
    $sformat(s, "%s\n settings[%s]\t=\t%h\n", s, i, writable[i] );
  foreach (readonly[i]) // Convert to string function reusing s:
    $sformat(s, "%s\n readonly[%s]\t=\t%h\n", s, i, readonly[i] );
  return s;

endfunction:convert2string

function void autb_csr_seq_item::do_print(uvm_printer printer);
  printer.m_string = convert2string();
endfunction:do_print

function void autb_csr_seq_item:: do_record(uvm_recorder recorder);
  string i,s;
  super.do_record(recorder);
  // Use the record macros to record the item fields:
  `uvm_record_field("design_state_name", design_state_name)
  foreach (writable[i]) begin// Convert to string function reusing s:
      s.hextoa(writable[i]);
      `uvm_record_field({"writable[",i,"]"},s)
  end
  foreach (readonly[i]) begin// Convert to string function reusing s:
      s.hextoa(readonly[i]);
      `uvm_record_field({"readonly[",i,"]"},s )
  end
endfunction:do_record
