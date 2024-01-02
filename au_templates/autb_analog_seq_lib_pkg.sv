package {{name[:-3]}}_analog_seq_lib_pkg;
    import uvm_pkg::*;
    import autb_generic_agent_pkg::*;
    class analog_on_seq extends uvm_sequence#(autb_generic_seq_item);
        `uvm_object_utils(analog_on_seq)
        function new(string name = "analog_on_seq");
            super.new(name);
        endfunction
        task body;
            autb_generic_seq_item analog_on_item;
              {% for port,item in blocks['analog']['ports'].items() %}{% if item.get('analog_info') %}{% if item['analog_info'].get('wavetype') -%}
              {%- if item['analog_info']['wavetype'] in ['dc'] and item['dir'] in ['output'] %}{%if item['msb'] %}
              {%- for index in range(item[lsb],item[msb]+1) %}real {{port}}_{{index}}$Vset; string {{port}}_{{index}}$Vset$string;
              {%- endfor%}{%else%}real {{port}}$Vset; string {{port}}$Vset$string; 
              {% endif%}{%- elif item['analog_info']['wavetype'] in ['rfsine'] and item['dir'] in ['output'] -%}
              {%- if item['analog_info'].get('pair_name') %}{%if item['msb'] %}
              {%- for index in range(item[lsb],item[msb]+1) %}real {{item['analog_info']['pair_name']}}_{{index}}$Freq; string {{item['analog_info']['pair_name']}}_{{index}}$Freq$string;
              real {{item['analog_info']['pair_name']}}_{{index}}$Amp;              string {{item['analog_info']['pair_name']}}_{{index}}$Amp$string;
              real {{item['analog_info']['pair_name']}}_{{index}}$SampleRate;       string {{item['analog_info']['pair_name']}}_{{index}}$SampleRate$string;
              bit {{item['analog_info']['pair_name']}}_{{index}}$Enable;            string {{item['analog_info']['pair_name']}}_{{index}}$Enable$string;
              {% endfor%}{%else%}real {{item['analog_info']['pair_name']}}$Freq; string {{item['analog_info']['pair_name']}}$Freq$string;
              real {{item['analog_info']['pair_name']}}$Amp;              string {{item['analog_info']['pair_name']}}$Amp$string;
              real {{item['analog_info']['pair_name']}}$SampleRate;       string {{item['analog_info']['pair_name']}}$SampleRate$string;
              bit {{item['analog_info']['pair_name']}}$Enable;            string {{item['analog_info']['pair_name']}}$Enable$string;
              {% endif%}{%else%}{%if item['msb'] %}
              {%- for index in range(item[lsb],item[msb]+1) %}real {{port}}_{{index}}$Freq;               string {{port}}_{{index}}$Freq$string; 
              real {{port}}_{{index}}$Amp;                        string {{port}}_{{index}}$Amp$string; 
              real {{port}}_{{index}}$SampleRate;                 string {{port}}_{{index}}$SampleRate$string; 
              bit {{port}}_{{index}}$Enable;                      string {{port}}_{{index}}$Enable$string; 
              {% endfor%}{%else%}real {{port}}$Freq;               string {{port}}$Freq$string; 
              real {{port}}$Amp;                        string {{port}}$Amp$string; 
              real {{port}}$SampleRate;                 string {{port}}$SampleRate$string; 
              bit {{port}}$Enable;                      string {{port}}$Enable$string; 
              {% endif %}{% endif %}{% endif %}{% endif %}{%endif%}{% endfor %}
          
            begin
              analog_on_item = autb_generic_seq_item::type_id::create("analog_on_item");
              {% for port,item in blocks['analog']['ports'].items() %}{% if item.get('analog_info') %}{% if item['analog_info'].get('wavetype') -%}
              {%- if item['analog_info']['wavetype'] in ['dc'] and item['dir'] in ['output'] %}{%if item['msb'] %}
              {%- for index in range(item[lsb],item[msb]+1) %}{{port}}_{{index}}$Vset = {{item['analog_info']['nominal_value']|default('0.0')}};
              {{port}}_{{index}}$Vset$string.realtoa({{port}}_{{index}}$Vset); 
              {%- endfor%}{%else%}{{port}}$Vset = {{item['analog_info']['nominal_value']|default('0.0')}};
              {{port}}$Vset$string.realtoa({{port}}$Vset); 
              {% endif %}{%- elif item['analog_info']['wavetype'] in ['rfsine'] and item['dir'] in ['output'] -%}
              {%- if item['analog_info'].get('pair_name') %}{%if item['msb'] %}
              {%- for index in range(item[lsb],item[msb]+1) %}{{item['analog_info']['pair_name']}}_{{index}}$Freq = {{item['analog_info']['Freq']|default('15e6')}}; 
              {{item['analog_info']['pair_name']}}_{{index}}$Freq$string.realtoa({{item['analog_info']['pair_name']}}_{{index}}$Freq);
              {{item['analog_info']['pair_name']}}_{{index}}$Amp = {{item['analog_info']['Amp']|default('0.5')}};
              {{item['analog_info']['pair_name']}}_{{index}}$Amp$string.realtoa({{item['analog_info']['pair_name']}}_{{index}}$Amp);
              {{item['analog_info']['pair_name']}}_{{index}}$SampleRate = {{item['analog_info']['SampleRate']|default('300e6')}}; 
              {{item['analog_info']['pair_name']}}_{{index}}$SampleRate$string.realtoa({{item['analog_info']['pair_name']}}_{{index}}$SampleRate); 
              {{item['analog_info']['pair_name']}}_{{index}}$Enable = 1;
              {{item['analog_info']['pair_name']}}_{{index}}$Enable$string.itoa({{item['analog_info']['pair_name']}}_{{index}}$Enable);
              {%- endfor%}{% else %}{{item['analog_info']['pair_name']}}$Freq = {{item['analog_info']['Freq']|default('15e6')}}; 
              {{item['analog_info']['pair_name']}}$Freq$string.realtoa({{item['analog_info']['pair_name']}}$Freq);
              {{item['analog_info']['pair_name']}}$Amp = {{item['analog_info']['Amp']|default('0.5')}};
              {{item['analog_info']['pair_name']}}$Amp$string.realtoa({{item['analog_info']['pair_name']}}$Amp);
              {{item['analog_info']['pair_name']}}$SampleRate = {{item['analog_info']['SampleRate']|default('300e6')}}; 
              {{item['analog_info']['pair_name']}}$SampleRate$string.realtoa({{item['analog_info']['pair_name']}}$SampleRate); 
              {{item['analog_info']['pair_name']}}$Enable = 1;
              {{item['analog_info']['pair_name']}}$Enable$string.itoa({{item['analog_info']['pair_name']}}$Enable);
              {% endif %}{% else %}{%if item['msb'] %}
              {%- for index in range(item[lsb],item[msb]+1) %}{{port}}_{{index}}$Freq = {{item['analog_info']['Freq']|default('10e6')}};
              {{port}}_{{index}}$Freq$string.realtoa({{port}}_{{index}}$Freq); 
              {{port}}_{{index}}$Amp = {{item['analog_info']['Amp']|default('0.5')}};
              {{port}}_{{index}}$Amp$string.realtoa({{port}}_{{index}}$Amp); 
              {{port}}_{{index}}$SampleRate = {{item['analog_info']['SampleRate']|default('300e6')}};
              {{port}}_{{index}}$SampleRate$string.realtoa({{port}}_{{index}}$SampleRate); 
              {{port}}_{{index}}$Enable = 1;
              {{port}}_{{index}}$Enable$string.itoa({{port}}_{{index}}$Enable); 
              {%- endfor%}{% else %}{{port}}$Freq = {{item['analog_info']['Freq']|default('10e6')}};
              {{port}}$Freq$string.realtoa({{port}}$Freq); 
              {{port}}$Amp = {{item['analog_info']['Amp']|default('0.5')}};
              {{port}}$Amp$string.realtoa({{port}}$Amp); 
              {{port}}$SampleRate = {{item['analog_info']['SampleRate']|default('300e6')}};
              {{port}}$SampleRate$string.realtoa({{port}}$SampleRate); 
              {{port}}$Enable = 1;
              {{port}}$Enable$string.itoa({{port}}$Enable); 
              {% endif %}{% endif %}{% endif %}{% endif %}{% endif %}{% endfor %}
              start_item(analog_on_item);
              analog_on_item.settings["action"] = "analog_on";
              //assert(analog_on_item.randomize());
              {% for port,item in blocks['analog']['ports'].items() %}{% if item.get('analog_info') %}{% if item['analog_info'].get('wavetype') -%}
              {%- if item['analog_info']['wavetype'] in ['dc'] and item['dir'] in ['output'] %}{%if item['msb'] %}
              {%- for index in range(item[lsb],item[msb]+1) %}analog_on_item.settings["{{port}}_{{index}}$Vset"] = {{port}}_{{index}}$Vset$string; 
              {%- endfor%}{% else %}analog_on_item.settings["{{port}}$Vset"] = {{port}}$Vset$string; 
              {% endif %}{%- elif item['analog_info']['wavetype'] in ['rfsine'] and item['dir'] in ['output'] -%}
              {%- if item['analog_info'].get('pair_name') %}{%if item['msb'] %}
              {%- for index in range(item[lsb],item[msb]+1) %}analog_on_item.settings["{{item['analog_info']['pair_name']}}_{{index}}$Freq"] = {{item['analog_info']['pair_name']}}_{{index}}$Freq$string;
              analog_on_item.settings["{{item['analog_info']['pair_name']}}_{{index}}$Amp"] = {{item['analog_info']['pair_name']}}_{{index}}$Amp$string;
              analog_on_item.settings["{{item['analog_info']['pair_name']}}_{{index}}$SampleRate"] = {{item['analog_info']['pair_name']}}_{{index}}$SampleRate$string;
              analog_on_item.settings["{{item['analog_info']['pair_name']}}_{{index}}$Enable"] = {{item['analog_info']['pair_name']}}_{{index}}$Enable$string;
              {%- endfor%}{% else %}analog_on_item.settings["{{item['analog_info']['pair_name']}}$Freq"] = {{item['analog_info']['pair_name']}}$Freq$string;
              analog_on_item.settings["{{item['analog_info']['pair_name']}}$Amp"] = {{item['analog_info']['pair_name']}}$Amp$string;
              analog_on_item.settings["{{item['analog_info']['pair_name']}}$SampleRate"] = {{item['analog_info']['pair_name']}}$SampleRate$string;
              analog_on_item.settings["{{item['analog_info']['pair_name']}}$Enable"] = {{item['analog_info']['pair_name']}}$Enable$string;
              {% endif %}{%else%}
              {%if item['msb'] %}
              {%- for index in range(item[lsb],item[msb]+1) %}analog_on_item.settings["{{port}}_{{index}}$Freq"] = {{port}}_{{index}}$Freq$string; 
              analog_on_item.settings["{{port}}_{{index}}$Amp"] = {{port}}_{{index}}$Amp$string; 
              analog_on_item.settings["{{port}}_{{index}}$SampleRate"] = {{port}}_{{index}}$SampleRate$string; 
              analog_on_item.settings["{{port}}_{{index}}$Enable"] = {{port}}_{{index}}$Enable$string; 
              {%- endfor%}{% else %}analog_on_item.settings["{{port}}$Freq"] = {{port}}$Freq$string; 
              analog_on_item.settings["{{port}}$Amp"] = {{port}}$Amp$string; 
              analog_on_item.settings["{{port}}$SampleRate"] = {{port}}$SampleRate$string; 
              analog_on_item.settings["{{port}}$Enable"] = {{port}}$Enable$string; 
              {% endif %}{% endif %}{% endif %}{% endif %}{% endif %}{% endfor %}

              finish_item(analog_on_item);
            end
          
          endtask: body
        endclass: analog_on_seq
    endpackage: {{name[:-3]}}_analog_seq_lib_pkg

