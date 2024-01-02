package {{name[:-3]}}_power_seq_lib_pkg;
    import uvm_pkg::*;
    import autb_generic_agent_pkg::*;
    //default sequence to set all supplies on to nominal voltages
    // this could be in an include file
    class power_on_seq extends uvm_sequence#(autb_generic_seq_item);
        `uvm_object_utils(power_on_seq)
        function new(string name = "power_on_seq");
            super.new(name);
        endfunction
        task body;
            autb_generic_seq_item power_on_reg;
            {% for port,portitem in blocks["power"]['ports'].items() %}{% if ((portitem['dir'] == 'output') and ( portitem['supply_type'] in ['volts'])) %}{%if portitem['msb']   %}
            {% for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}real {{port}}_vset_{{index}};
            {%endfor%}{%else%}real {{port}}_vset;
            {%endif%}{%endif%}{% endfor %}
            {% for port,portitem in blocks["power"]['ports'].items() %}{% if ((portitem['dir'] == 'output') and ( portitem['supply_type'] in ['volts'])) %}{%if portitem['msb']   %}
            {% for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}string s_{{port}}_{{index}};
            {%endfor%}{%else%}string s_{{port}};
            {%endif%}{%endif%}{% endfor %}
        
            string s_enable;
            begin
                power_on_reg = autb_generic_seq_item::type_id::create("power_on_reg");
                // nothing to randomize here.. no use in late randomization.(after start_item)
                s_enable.itoa(1);
                {% for port,portitem in blocks["power"]['ports'].items() %}{% if ((portitem['dir'] == 'output') and ( portitem['supply_type'] in ['volts'])) %}{%if portitem['msb']   %}
                {% for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}{{port}}_vset_{{index}} = {{portitem['supply_nom']|replace('P','.')|replace('p','.')}};
                {%endfor%}{%else%}{{port}}_vset = {{portitem['supply_nom']|replace('P','.')|replace('p','.')}};
                {%endif%}{%endif%}{% endfor %}
                {% for port,portitem in blocks["power"]['ports'].items() %}{% if ((portitem['dir'] == 'output') and ( portitem['supply_type'] in ['volts'])) %}{%if portitem['msb']   %}
                {% for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}s_{{port}}_{{index}}.realtoa({{port}}_vset_{{index}});
                {%endfor%}{%else%}s_{{port}}.realtoa({{port}}_vset);
                {%endif%}{%endif%}{% endfor %}
                power_on_reg.settings["action"] = "poweron";
                {% for port,portitem in blocks["power"]['ports'].items() %}{% if ((portitem['dir'] == 'output') and ( portitem['supply_type'] in ['volts'])) %}{%if portitem['msb']   %}
                {% for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}power_on_reg.settings["{{port}}_vset_{{index}}"] = s_{{port}}_{{index}};
                {%endfor%}{%else%}power_on_reg.settings["{{port}}_vset"] = s_{{port}};
                {%endif%}{%endif%}{% endfor %}
                {% for port,portitem in blocks["power"]['ports'].items() %}{% if ((portitem['dir'] == 'output') and ( portitem['supply_type'] in ['volts'])) %}{%if portitem['msb']   %}
                {% for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}power_on_reg.settings["{{port}}_enable_{{index}}"] = s_enable;
                {%endfor%}{%else%}power_on_reg.settings["{{port}}_enable"] = s_enable;
                {%endif%}{%endif%}{% endfor %}


                start_item(power_on_reg);
                //assert(power_on_reg.randomize());
                finish_item(power_on_reg);
            end

        endtask: body
    endclass: power_on_seq
endpackage: {{name[:-3]}}_power_seq_lib_pkg

