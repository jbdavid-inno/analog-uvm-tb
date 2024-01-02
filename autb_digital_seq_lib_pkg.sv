package {{blocks['dut']['name']}}_digital_seq_lib_pkg;
    import uvm_pkg::*;
    import autb_generic_agent_pkg::*;
    //default sequence to set all supplies on to nominal voltages
    class start_clocks_seq extends uvm_sequence#(autb_generic_seq_item);
        `uvm_object_utils(start_clocks_seq)
        function new(string name = "start_clocks_seq");
            super.new(name);
        endfunction
        task body;
            autb_generic_seq_item start_clocks_item;
            {% for port,portitem in blocks['digital']['ports'].items()  %}{%if portitem['digital_type'] in ['clock'] %}{%if portitem['dir'] in ['output'] %}string {{port}}$s_freq;
            real {{port}}$freq ;
            {%endif%}{%endif%}{%endfor%}
            string s_enable;
            begin
                // example 
                start_clocks_item = autb_generic_seq_item::type_id::create("start_clocks_item");
                // nothing to randomize here.. no use in late randomization.(after start_item)
                {% for port,portitem in blocks['digital']['ports'].items()  %}{%if portitem['digital_type'] in ['clock'] %}{%if portitem['dir'] in ['output'] and portitem.get('digital_info') and portitem['digital_info'].get('nominal_freq') %}{{port}}$freq = {{ portitem['digital_info']['nominal_freq']|replace("M","e6")|replace("K","1e3")|replace("G","1e9")}};
                {{port}}$s_freq.realtoa({{port}}$freq);
                {%endif%}{%endif%}{%endfor%}s_enable.itoa(1);
                start_clocks_item.settings["action"] = "start_clocks";
                {% for port,portitem in blocks['digital']['ports'].items()  %}{%if portitem['digital_type'] in ['clock'] %}{%if portitem['dir'] in ['output'] %}start_clocks_item.settings["{{port}}$freq"] = {{port}}$s_freq;
                start_clocks_item.settings["{{port}}$enable"] = s_enable;
                {%endif%}{%endif%}{%endfor%}
                start_item(start_clocks_item);
                //assert(start_clocks_item.randomize());
                finish_item(start_clocks_item);
            end

        endtask: body
    endclass: start_clocks_seq
endpackage: {{blocks['dut']['name']}}_digital_seq_lib_pkg

