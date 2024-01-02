//SystemVerilog HDL for "{{library_name}}", "{{name}}" "svlog"
// auto generated bias top
module {{ name }} ( {% set comma=joiner(', ') %}{% for port,portitem in ports.items()  %}{{ comma() }}
	{{portitem['dir']}} {%if portitem['msb'] %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%else%} 	{%endif%} 	{{port}} {% endfor %}
);
// declarations for bused signals
{% for port,portitem in ports.items() %}{% if portitem.msb %} interconnect [{{fportitem['msb']}}:{{fportitem['lsb']}}] {{port}};
{% endif %}{% endfor %}
// instantiate bias if
import uvm_pkg::uvm_config_db;
autb_generic_if bias_if(); // interface contains an associative array of string with string index settings
// if uvm , register if with config 
initial begin 
	uvm_config_db#(virtual autb_generic_if)::set(null, "uvm_test_top", "bias_vif", bias_if);
end
// ams block 
{{name}}_adrive bias_adrive({% set comma=joiner(', ') %}{% for port,portitem in ports.items()  %}{{ comma() }}
	.{{port}}({{port}}){%endfor%}
);
// set voltages/currents from if.. 
    {% for port,portitem in ports.items() %}{% if portitem['dir'] == 'output' %}{%if portitem['msb']   %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1,1) %}always @(bias_if.settings["{{port}}_{%if portitem['bias_type'] in ['current']%}i{%else%}v{%endif%}set_{{index}}"])	bias_adrive.{{port}}_{%if portitem['bias_type'] in ['current']%}i{%else%}v{%endif%}set_{{index}} =  bias_if.settings["{{port}}_{%if portitem['bias_type'] in ['current']%}i{%else%}v{%endif%}set_{{index}}"].atoreal();
	{%endfor%}{%else%}always @(bias_if.settings["{{port}}_{%if portitem['bias_type'] in ['current']%}i{%else%}v{%endif%}set"]) bias_adrive.{{port}}_{%if portitem['bias_type'] in ['current']%}i{%else%}v{%endif%}set =  bias_if.settings["{{port}}_{%if portitem['bias_type'] in ['current']%}i{%else%}v{%endif%}set"].atoreal();
	{%endif%}{%endif%}{% endfor %}
	// set enable from if.. 
    {% for port,portitem in ports.items() %}{% if (portitem['dir'] == 'output' and (not portitem['bias_type'] in ['current'])) %}{%if portitem['msb']   %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1,1) %}always @(bias_if.settings["{{port}}_enable_{{index}}"])	bias_adrive.{{port}}_enable_{{index}} =  bias_if.settings["{{port}}_enable_{{index}}"].atoi();
	{%endfor%}{%else%}always @(bias_if.settings["{{port}}_enable"]) bias_adrive.{{port}}_enable =  bias_if.settings["{{port}}_enable"].atoi();
	{%endif%}{%endif%}{% endfor %}
	// set ron from if.. 
    {% for port,portitem in ports.items() %}{% if (portitem['dir'] == 'output' and (not portitem['bias_type'] in ['current'])) %}{%if portitem['msb']   %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1,1) %}always @(bias_if.settings["{{port}}_ron_{{index}}"])	bias_adrive.{{port}}_ron_{{index}} =  bias_if.settings["{{port}}_ron_{{index}}"].atoreal();
	{%endfor%}{%else%}always @(bias_if.settings["{{port}}_ron"]) bias_adrive.{{port}}_ron =  bias_if.settings["{{port}}_ron"].atoreal();
	{%endif%}{%endif%}{% endfor %}
	// set roff from if.. 
    {% for port,portitem in ports.items() %}{% if (portitem['dir'] == 'output'and (not portitem['bias_type'] in ['current'])) %}{%if portitem['msb']   %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1,1) %}always @(bias_if.settings["{{port}}_roff_{{index}}"])	bias_adrive.{{port}}_roff_{{index}} =  bias_if.settings["{{port}}_roff_{{index}}"].atoreal();
	{%endfor%}{%else%}always @(bias_if.settings["{{port}}_roff"]) bias_adrive.{{port}}_roff =  bias_if.settings["{{port}}_roff"].atoreal();
	{%endif%}{%endif%}{% endfor %}
	// set conductance from if..
	{% for port,portitem in ports.items() %}{% if (portitem['dir'] == 'output' and (portitem['bias_type'] in ['current']))%}{%if portitem['msb']   %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1,1) %}always @(bias_if.settings["{{port}}_gset_{{index}}"])	bias_adrive.{{port}}_gset_{{index}} =  bias_if.settings["{{port}}_gset_{{index}}"].atoreal();
	{%endfor%}{%else%}always @(bias_if.settings["{{port}}_gset"]) bias_adrive.{{port}}_gset =  bias_if.settings["{{port}}_gset"].atoreal();
	{%endif%}{%endif%}{% endfor %}
//set if from input signals
    {% for port,portitem in ports.items() %}{% if portitem['dir'] == 'input' %}{%if portitem['msb']   %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1,1) %}always @(power_adrive{{port}}_volts_{{index}}) bias_if.bias_observations["{{port}}_volts_{{index}}"].realtoa({{port}}_volts_{{index}}) ;
	{%endfor%}{%else%}always @(power_adrive{{port}}_volts) bias_if.bias_observations["{{port}}_volts"].realtoa({{port}}_volts) ;
	{%endif%}{%endif%}{% endfor %}
endmodule