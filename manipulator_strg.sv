module manipulator_strg(output var string manipulated_value);
    parameter string manipulated_var_name = "";
    string myID = $sformatf("%M");
  string my_if_name ;
function string get_manipulated_var_name();
    return manipulated_var_name;
endfunction
manipulator_strg_if A_IF(.manipulated_value(manipulated_value ));
    `ifdef uvm_info
 //   `include "uvm_macros.svh"
import uvm_pkg::uvm_config_db;

initial begin 
    //A_IF.manipulated_var_name = manipulated_var_name;
    $display( "%M manipulator instance");
for (int i = 0; i<myID.len();i++ ) 
    if (myID[i] == ".")  myID[i] = "_";

    //$swrite(myID,"%M.%s",manipulated_var_name);
    $display(myID);
    $swrite(my_if_name, "%s__%s_mpltr_strg_vif",myID,manipulated_var_name);
	uvm_config_db#(virtual manipulator_strg_if)::set(null, "uvm_test_top", my_if_name, A_IF);
    $display("set cfg for vif %s",my_if_name);
end
`endif

endmodule