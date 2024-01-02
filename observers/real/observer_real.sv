module observer_real(input real observed_value);
    parameter string observed_var_name = "";
    string myID = $sformatf("%M");
  string my_if_name ;
function string get_observed_var_name();
    return observed_var_name;
endfunction
    observer_real_if A_IF(.observed_value(observed_value ));
    `ifdef uvm_info
 //   `include "uvm_macros.svh"
import uvm_pkg::uvm_config_db;

initial begin 
    //A_IF.observed_var_name = observed_var_name;
    $display( "%M observer instance");
for (int i = 0; i<myID.len();i++ ) 
    if (myID[i] == ".")  myID[i] = "_";

    //$swrite(myID,"%M.%s",observed_var_name);
    $display(myID);
    $swrite(my_if_name, "%s__%s_obsvr_real_vif",myID,observed_var_name);
	uvm_config_db#(virtual observer_real_if)::set(null, "uvm_test_top", my_if_name, A_IF);
    $display("set cfg for vif %s",my_if_name);
end
`endif

endmodule