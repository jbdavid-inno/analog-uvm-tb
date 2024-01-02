package {{name[:-3]}}_bias_seq_lib_pkg;
    import uvm_pkg::*;
    import autb_generic_agent_pkg::*;
    //default sequence to set all supplies on to nominal voltages
    class bias_on_seq extends uvm_sequence#(autb_generic_seq_item);
        `uvm_object_utils(bias_on_seq)
        function new(string name = "bias_on_seq");
            super.new(name);
        endfunction
        task body;
            autb_generic_seq_item bias_on_item;
            {% for port,portitem in blocks["bias"]['ports'].items() %}{% if ((portitem['dir'] == 'output') ) %}{%if portitem['msb']   %}
            {% for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}real {{port}}_iset_{{index}};
            {%endfor%}{%else%}real {{port}}_iset;
            {%endif%}{%endif%}{% endfor %}
            real gset;
            {% for port,portitem in blocks["bias"]['ports'].items() %}{% if ((portitem['dir'] == 'output') ) %}{%if portitem['msb']   %}
            {% for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}string s_{{port}}_{{index}};
            {%endfor%}{%else%}string s_{{port}};
            {%endif%}{%endif%}{% endfor %}
            string s_gset;
            begin
                bias_on_item = autb_generic_seq_item::type_id::create("bias_on_item");
                // nothing to randomize here.. no use in late randomization.(after start_item)
                {% for port,portitem in blocks["bias"]['ports'].items() %}{% if ((portitem['dir'] == 'output') ) %}{%if portitem['msb']   %}
                {% for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}{{port}}_iset_{{index}} = {%if portitem['ibias_nom']%}-{{(portitem['ibias_nom']|replace('u','e-6'))|replace('p','.')}}{%else%}-10e-6{%endif%};
                {%endfor%}{%else%}{{port}}_iset = = {%if portitem['ibias_nom']%}-{{(portitem['ibias_nom']|replace('u','e-6'))|replace('p','.')}}{%else%}-10e-6{%endif%};
                {%endif%}{%endif%}{% endfor %}
                gset = 1e-8;
                {% for port,portitem in blocks["bias"]['ports'].items() %}{% if ((portitem['dir'] == 'output') ) %}{%if portitem['msb']   %}
                {% for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}s_{{port}}_{{index}}.realtoa({{port}}_iset_{{index}});
                {%endfor%}{%else%}s_{{port}}.realtoa({{port}}_iset);
                {%endif%}{%endif%}{% endfor %}
                s_gset.realtoa(gset);
                bias_on_item.settings["action"] = "biason";
                {% for port,portitem in blocks["bias"]['ports'].items() %}{% if ((portitem['dir'] == 'output') ) %}{%if portitem['msb']   %}
                {% for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}bias_on_item.settings["{{port}}_iset_{{index}}"] = s_{{port}}_{{index}};
                {%endfor%}{%else%}bias_on_item.settings["{{port}}_iset"] = s_{{port}};
                {%endif%}{%endif%}{% endfor %}
                {% for port,portitem in blocks["bias"]['ports'].items() %}{% if ((portitem['dir'] == 'output') ) %}{%if portitem['msb']   %}
                {% for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}bias_on_item.settings["{{port}}_gset_{{index}}"] = s_gset;
                {%endfor%}{%else%}bias_on_item.settings["{{port}}_gset"] = s_gset;
                {%endif%}{%endif%}{% endfor %}


                start_item(bias_on_item);
                //assert(bias_on_item.randomize());
                finish_item(bias_on_item);
            end

        endtask: body
    endclass: bias_on_seq
endpackage: {{name[:-3]}}_bias_seq_lib_pkg

