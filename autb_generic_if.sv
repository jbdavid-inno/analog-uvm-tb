// an interface
interface autb_generic_if();
    string settings[string];
    string observations[string];
    event sample_trigger;
    string sequence_name;
    string design_state_name;
endinterface