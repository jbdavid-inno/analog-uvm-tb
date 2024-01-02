class manipulator_strg_util extends uvm_object;
    `uvm_object_utils(manipulator_strg_util)
    string manipulated_var_name ;
    function new(string name = "manipulator_strg_util");
        super.new();
    endfunction

    //virtual inf 
    protected virtual manipulator_strg_if m_vif;

    //data members 
    string manipulated_value;

    // methods
    function void set_manipulated_value(input string  value);
        m_vif.manipulated_value = value;
    endfunction 
    
    // Helper Methods:
  function void set_vif(virtual manipulator_strg_if vif);
    m_vif = vif;
    m_vif.proxy = this;
    manipulated_var_name = m_vif.manipulated_variable;
  endfunction : set_vif
endclass : manipulator_strg_util