interface manipulator_strg_if(output var string manipulated_value);
    const string manipulated_variable = get_manipulated_var_name() ;
    manipulator_strg_pkg::manipulator_strng_util proxy;
    always @(proxy.manipulated_value) 
        manipulated_value = proxy.manipulated_value; 
    
endinterface