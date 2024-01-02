class observer_real_util extends uvm_object;
    `uvm_object_utils(observer_real_util)
    string observed_var_name ;
    function new(string name = "observer_real_util");
        super.new();
    endfunction

    //virtual inf 
    protected virtual observer_real_if m_vif;

    //data members 
    real observed_value;

    // methods
    function bit is_above_abs(input real  threshold);
        return observed_value>threshold;
    endfunction 
    function bit is_inside_range(input real min, max);
        return (observed_value>=min && observed_value<=max);
    endfunction 

    // Helper Methods:
  function void set_vif(virtual observer_real_if vif);
    m_vif = vif;
    m_vif.proxy = this;
    observed_var_name = m_vif.observed_variable;
  endfunction : set_vif
endclass : observer_real_util