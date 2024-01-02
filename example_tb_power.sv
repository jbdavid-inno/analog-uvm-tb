//SystemVerilog HDL for "{{library_name}}", "{{name}}" "svlog"
module {{ name }} ( {% set comma=joiner(', ') %}{% for port,portitem in ports.items()  %}{{ comma() }}
	{{portitem['dir']}} interconnect {%if portitem['msb'] %}[{{portitem['msb']}}:{{portitem['lsb']}}]
{%- else %} 	{%endif%} 	{{port}} {% endfor %}
);
import uvm_pkg::uvm_config_db;
autb_generic_if pwr_if(); // interface contains an associative array of string with string index settings
initial begin 
	uvm_config_db#(virtual autb_generic_if)::set(null, "uvm_test_top", "power_vif", pwr_if);
end
{{name}}_adrive power_adrive({% set comma=joiner(', ') %}{% for port,portitem in ports.items()  %}{{ comma() }}
	.{{port}}({{port}}){%endfor%});
bit sample_trigger;
always @(pwr_if.settings["trigger"] or pwr_if.sample_trigger) begin
	sample_trigger = pwr_if.settings["trigger"].atoi();
	if (sample_trigger ) begin
  		power_adrive.sample_trigger = 1;
  		#1ps power_adrive.sample_trigger = 0;
	end
end
    {% for port,portitem in ports.items() %}
    {%- if ((portitem['dir'] == 'output') and ( portitem['supply_type'] in ['volts'])) %}{%if portitem['msb']   %}
	{%- for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}always @(pwr_if.settings["{{port}}_vset_{{index}}"])	
		power_adrive.{{port}}_vset_{{index}} =  pwr_if.settings["{{port}}_vset_{{index}}"].atoreal();
	{%endfor%}	{%else%}always @(pwr_if.settings["{{port}}_vset"]) 
		power_adrive.{{port}}_vset =  pwr_if.settings["{{port}}_vset"].atoreal();
	{%endif%}{%endif%}{% endfor %}

    // set enable from if.. 
    {% for port,portitem in ports.items() %}{% if ((portitem['dir'] == 'output') and  portitem['supply_type'] in ['volts']) %}{%if portitem['msb']   %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}always @(pwr_if.settings["{{port}}_enable_{{index}}"])	power_adrive.{{port}}_enable_{{index}} =  pwr_if.settings["{{port}}_enable_{{index}}"].atoi();
	{%endfor%}{%else%}always @(pwr_if.settings["{{port}}_enable"]) power_adrive.{{port}}_enable =  pwr_if.settings["{{port}}_enable"].atoi();
	{%endif%}{%endif%}{% endfor %}
	// set ron from if.. 
    {% for port,portitem in ports.items() %}{% if ((portitem['dir'] == 'output') and ( portitem['supply_type'] in ['volts'])) %}{%if portitem['msb']   %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}always @(pwr_if.settings["{{port}}_ron_{{index}}"])	power_adrive.{{port}}_ron_{{index}} =  pwr_if.settings["{{port}}_ron_{{index}}"].atoreal();
	{%endfor%}{%else%}always @(pwr_if.settings["{{port}}_ron"]) power_adrive.{{port}}_ron =  pwr_if.settings["{{port}}_ron"].atoreal();
	{%endif%}{%endif%}{% endfor %}
	// set roff from if.. 
    {% for port,portitem in ports.items() %}{% if ((portitem['dir'] == 'output') and ( portitem['supply_type'] in ['volts'])) %}{%if portitem['msb']   %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}always @(pwr_if.settings["{{port}}_roff_{{index}}"])	power_adrive.{{port}}_roff_{{index}} =  pwr_if.settings["{{port}}_roff_{{index}}"].atoreal();
	{%endfor%}{%else%}always @(pwr_if.settings["{{port}}_roff"]) power_adrive.{{port}}_roff =  pwr_if.settings["{{port}}_roff"].atoreal();
	{%endif%}{%endif%}{% endfor %}
	// set transition_time from if.. 
    {% for port,portitem in ports.items() %}{% if ((portitem['dir'] == 'output') and ( portitem['supply_type'] in ['volts'])) %}{%if portitem['msb']   %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}always @(pwr_if.settings["{{port}}_tt_{{index}}"])	power_adrive.{{port}}_tt_{{index}} =  pwr_if.settings["{{port}}_tt_{{index}}"].atoreal();
	{%endfor%}{%else%}always @(pwr_if.settings["{{port}}_tt"]) power_adrive.{{port}}_tt =  pwr_if.settings["{{port}}_tt"].atoreal();
	{%endif%}{%endif%}{% endfor %}
//set if from input signals
    {% for port,portitem in ports.items() %}{% if portitem['dir'] == 'input' %}{%if portitem['msb']   %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1) %}always @(power_adrive{{port}}_volts_{{index}}) pwr_if.observations["{{port}}_volts_{{index}}"].realtoa({{port}}_volts_{{index}}) ;
	{%endfor%}{%else%}always @(power_adrive.{{port}}_volts) pwr_if.observations["{{port}}_volts"].realtoa(power_adrive.{{port}}_volts) ;
	{%endif%}{%endif%}{% endfor %}
endmodule