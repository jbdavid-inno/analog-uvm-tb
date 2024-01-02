//default sequence to set all supplies on to nominal voltages
class {{block_name}}_on_seq extends uvm_sequence#(autb_csr_seq_item);
    `uvm_object_utils({{block_name}}_on_seq)
    function new(string name = "{{block_name}}_on_seq");
        super.new(name);
    endfunction
    task body;
        autb_csr_seq_item {{block_name}}_on_item;
            {%for register,item in block_regs.items()%}{%if item['reg_info']['on_value']-%} {%if item['reg_info']['width']|int>32%}{%if item['reg_info']['width']|int>64%}int  {{register|replace('_digi','')}}_upper = {{item['reg_info']['on_value'][:-64]}};
            int  {{register|replace('_digi','')}}_middle = 'b{{item['reg_info']['on_value'][(item['reg_info']['width']-60):-32]}};
            {%else%}int  {{register|replace('_digi','')}}_upper = {{item['reg_info']['on_value'][:-32]}};
            {%endif%}int  {{register|replace('_digi','')}} = 'b{{item['reg_info']['on_value'][(item['reg_info']['width']-28):]}};
            {%else%}int  {{register|replace('_digi','')}} = {{item['reg_info']['on_value']}};
            {%endif%}{%endif%}{%endfor%}
               begin
            {{block_name}}_on_item = autb_csr_seq_item::type_id::create("{{block_name}}_on_item");
            // nothing to randomize here.. no use in late randomization.(after start_item)
            {%for register,item in block_regs.items()%}{%if item['reg_info']['on_value']-%}{{block_name}}_on_item.writable["{{register|replace('_digi','')}}"] = {{register|replace('_digi','')}};
            {%if item['reg_info']['width']|int>64%}{{block_name}}_on_item.writable["{{register|replace('_digi','')}}_middle"] = {{register|replace('_digi','')}}_middle;
            {%endif%}{%if item['reg_info']['width']|int>32%}{{block_name}}_on_item.writable["{{register|replace('_digi','')}}_upper"] = {{register|replace('_digi','')}}_upper;
            {%endif%}{%endif%}{%endfor%}
            {{block_name}}_on_item.delay_us = 3;


            start_item({{block_name}}_on_item);
            //assert({{block_name}}_on_item.randomize());
            finish_item({{block_name}}_on_item);
        end

    endtask: body
endclass: {{block_name}}_on_seq
