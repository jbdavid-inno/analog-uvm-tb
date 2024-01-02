class {{name[:-3]}}_vsequencer extends uvm_sequencer;
    `uvm_component_utils({{name[:-3]}}_vsequencer)
    autb_generic_sequencer analog_sqr;
    autb_generic_sequencer bias_sqr;
    autb_generic_sequencer digital_sqr;
    autb_generic_sequencer power_sqr;
    autb_csr_sequencer register_sqr;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        if (!uvm_config_db#(autb_generic_sequencer)::get(this, "", "analog_sqr", analog_sqr))
            `uvm_fatal("VSQR/CFG/NOAHB", "No analog_sqr specified for this instance");
        if (!uvm_config_db#(autb_generic_sequencer)::get(this, "", "bias_sqr", bias_sqr))
            `uvm_fatal("VSQR/CFG/NOAHB", "No bias_sqr specified for this instance");
        if (!uvm_config_db#(autb_generic_sequencer)::get(this, "", "digital_sqr", digital_sqr))
            `uvm_fatal("VSQR/CFG/NOAHB", "No digital_sqr specified for this instance");
        if (!uvm_config_db#(autb_generic_sequencer)::get(this, "", "power_sqr", power_sqr))
            `uvm_fatal("VSQR/CFG/NOAHB", "No power_sqr specified for this instance");
        if (!uvm_config_db#(autb_csr_sequencer)::get(this, "", "register_sqr", register_sqr))
            `uvm_fatal("VSQR/CFG/NOAHB", "No register_sqr specified for this instance");


    endfunction
endclass : {{name[:-3]}}_vsequencer