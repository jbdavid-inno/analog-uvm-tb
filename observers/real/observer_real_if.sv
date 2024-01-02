interface observer_real_if(input real observed_value);
    const string observed_variable = get_observed_var_name() ;
    observer_real_pkg::observer_real_util proxy;
    always @(observed_value) 
        proxy.observed_value = observed_value; 
    function bit between_abs(input real min, max);
        between_abs = observed_value>=min && observed_value<=max;
    endfunction 
    function bit above_abs(input real  threshold);
        return observed_value>threshold;
    endfunction 
endinterface