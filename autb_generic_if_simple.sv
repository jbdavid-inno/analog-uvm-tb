// interface for the autb_generic agent.
interface autb_generic_if();
    string settings[string], observations[string];
    event sample_trigger;
    string sequence_name, design_state_name;
endinterface