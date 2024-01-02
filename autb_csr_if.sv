//interface for the autb_csr agent 
interface autb_csr_if();
    int readonly[string], writable[string];
    string sequence_name, design_state_name;
    int delay_us, delay_ns;
    task delay(input int us_delay=1, ns_delay=0);
        if (us_delay) delay_us = us_delay;
        if (ns_delay) delay_ns = ns_delay;
        begin
            while (delay_us) begin
                #1us delay_us--;
            end
            while (delay_ns) begin
                #1ns delay_ns--;
            end
        end
    endtask
endinterface