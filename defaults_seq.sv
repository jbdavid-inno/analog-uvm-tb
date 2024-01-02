//default sequence to set all registers to hardware default values
class register_defaults_seq extends uvm_sequence#(autb_csr_seq_item);
    `uvm_object_utils(register_defaults_seq)
    function new(string name = "register_defaults_seq");
        super.new(name);
    endfunction
    task body;
        autb_csr_seq_item hw_defaults_item;
            {%for register,item in blocks.register.ports.items() %}{%if item['dir'] in ['output'] %}{%if item['reg_info']['width']|int>32 %}{%if item['reg_info']['width']|int>64 %}int  {{register|replace('_digi','')}}_upper = {{item['reg_info']['default'][:-64]}};
            int  {{register|replace('_digi','')}}_middle = 'b{{item['reg_info']['default'][(item['reg_info']['width']-60):-32]}};
            {%else%}int  {{register|replace('_digi','')}}_upper = {{item['reg_info']['default'][:-32]}};
            {%endif%}int  {{register|replace('_digi','')}} = 'b{{item['reg_info']['default'][(item['reg_info']['width']-28):]}};
            {%else%}int  {{register|replace('_digi','')}} = {{item['reg_info']['default']}};
            {%endif%}{%endif%}{%endfor%}
               begin
            hw_defaults_item = autb_csr_seq_item::type_id::create("hw_defaults_item");
            // nothing to randomize here.. no use in late randomization.(after start_item)
            {%for register,item in blocks.register.ports.items() %}{%if item['dir'] in ['output'] %}hw_defaults_item.writable["{{register|replace('_digi','')}}"] = {{register|replace('_digi','')}};
            {%if item['reg_info']['width']|int>64%}hw_defaults_item.writable["{{register|replace('_digi','')}}_middle"] = {{register|replace('_digi','')}}_middle;
            {%endif%}{%if item['reg_info']['width']|int>32%}hw_defaults_item.writable["{{register|replace('_digi','')}}_upper"] = {{register|replace('_digi','')}}_upper;
            {%endif%}{%endif%}{%endfor%}
            hw_defaults_item.delay_us = {{blocks['register']['delay_us']|default(1)}};


            start_item(hw_defaults_item);
            //assert(hw_defaults_item.randomize());
            finish_item(hw_defaults_item);
        end

    endtask: body
endclass: register_defaults_seq
