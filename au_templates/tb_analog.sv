//SystemVerilog HDL for "{{library_name}}", "{{name}}" "svlog"
// auto generated analog top
module {{ name }} ( {% set comma=joiner(', ') %}{% for port,portitem in ports.items()  %}{{ comma() }}
	{{portitem['dir']}} interconnect {%if portitem['msb'] %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%else%} 	{%endif%} 	{{port}} {% endfor %}
);
// instantiate analog if
import uvm_pkg::uvm_config_db;
autb_generic_if analog_if(); // interface contains an associative array of string with string index settings, and a trigger event
// if uvm , register if with config 
initial begin 
	uvm_config_db#(virtual autb_generic_if)::set(null, "uvm_test_top", "analog_vif", analog_if);
end
// ams block 
{{name}}_adrive analog_adrive({% set comma=joiner(', ') %}{% for port,portitem in ports.items()  %}{{ comma() }}
	.{{port}}({{port}}){%endfor%}
);
// set voltages/currents from if.. 
// hand coded
	always @(analog_if.sample_trigger) begin 
        analog_adrive.sample_trigger = 1;
        #1ns ;
        analog_adrive.sample_trigger = 0;
    end    
//set if from input signals
    {% for port,portitem in ports.items() %}{% if portitem['dir'] == 'input' %}{%if portitem['msb']   %}{%for index in range(portitem[lsb],portitem[msb]+1) %}always @(analog_adrive_adrive.{{port}}_{{index}}_volts) analog_if.observations["{{port}}_{{index}}_volts"].realtoa(analog_adrive.{{port}}_{{index}}_volts) ;
	{%endfor%}{%else%}always @(analog_adrive.{{port}}_volts) analog_if.observations["{{port}}_volts"].realtoa(analog_adrive.{{port}}_volts) ;
	{%endif%}
	{%endif%}{% endfor %}
	{% for port,portitem in ports.items() %}{% if portitem.get('analog_info') %}{% if portitem['analog_info'].get('wavetype') -%}
	{%- if portitem['analog_info']['wavetype'] in ['dc'] and portitem['dir'] in ['output'] %}{%if portitem['msb'] %}
	{%- for index in range(portitem[lsb],portitem[msb]+1) %}always @(analog_if.settings["{{port}}_{{index}}$Vset"]) analog_adrive.{{port}}_{{index}}$Vset = analog_if.settings["{{port}}_{{index}}$Vset"].atoreal();
	{%- endfor%}{%else%}always @(analog_if.settings["{{port}}$Vset"]) analog_adrive.{{port}}$Vset = analog_if.settings["{{port}}$Vset"].atoreal(); 
	{%- endif%}{%- elif portitem['analog_info']['wavetype'] in ['rfsine'] and portitem['dir'] in ['output'] -%}
	{%- if portitem['analog_info'].get('pair_name') %}{%if portitem['msb'] %}
	{%- for index in range(portitem[lsb],portitem[msb]+1) %}always @(analog_if.settings["{{portitem['analog_info']['pair_name']}}_{{index}}$Freq"]) analog_adrive.{{portitem['analog_info']['pair_name']}}_{{index}}$Freq = analog_if.settings["{{portitem['analog_info']['pair_name']}}_{{index}}$Freq"].atoreal();
	always @(analog_if.settings["{{portitem['analog_info']['pair_name']}}_{{index}}$Amp"]) analog_adrive.{{portitem['analog_info']['pair_name']}}_{{index}}$Amp =analog_if.settings["{{portitem['analog_info']['pair_name']}}_{{index}}$Amp"].atoreal();
	always @(analog_if.settings["{{portitem['analog_info']['pair_name']}}_{{index}}$SampleRate"]) analog_adrive.{{portitem['analog_info']['pair_name']}}_{{index}}$SampleRate =analog_if.settings["{{portitem['analog_info']['pair_name']}}_{{index}}$SampleRate"].atoreal();
	always @(analog_if.settings["{{portitem['analog_info']['pair_name']}}_{{index}}$Enable"]) analog_adrive.{{portitem['analog_info']['pair_name']}}_{{index}}$Enable =analog_if.settings["{{portitem['analog_info']['pair_name']}}_{{index}}$Enable"].atoi();
	{%- endfor%}{%else%}always @(analog_if.settings["{{portitem['analog_info']['pair_name']}}$Freq"]) analog_adrive.{{portitem['analog_info']['pair_name']}}$Freq =analog_if.settings["{{portitem['analog_info']['pair_name']}}$Freq"].atoreal();
	always @(analog_if.settings["{{portitem['analog_info']['pair_name']}}$Amp"]) analog_adrive.{{portitem['analog_info']['pair_name']}}$Amp =analog_if.settings["{{portitem['analog_info']['pair_name']}}$Amp"].atoreal();
	always @(analog_if.settings["{{portitem['analog_info']['pair_name']}}$SampleRate"]) analog_adrive.{{portitem['analog_info']['pair_name']}}$SampleRate =analog_if.settings["{{portitem['analog_info']['pair_name']}}$SampleRate"].atoreal();
	always @(analog_if.settings["{{portitem['analog_info']['pair_name']}}$Enable"]) analog_adrive.{{portitem['analog_info']['pair_name']}}$Enable =analog_if.settings["{{portitem['analog_info']['pair_name']}}$Enable"].atoi();
	{%- endif%}{%else%}{%if portitem['msb'] %}
	{%- for index in range(portitem[lsb],portitem[msb]+1) %}always @(analog_if.settings["{{port}}_{{index}}$Freq"]) analog_adrive.{{port}}_{{index}}$Freq =analog_if.settings["{{port}}_{{index}}$Freq"].atoreal() ; 
	always @(analog_if.settings["{{port}}_{{index}}$Amp"]) analog_adrive.{{port}}_{{index}}$Amp =analog_if.settings["{{port}}_{{index}}$Amp"].atoreal() ; 
	always @(analog_if.settings["{{port}}_{{index}}$SampleRate"]) analog_adrive.{{port}}_{{index}}$SampleRate  = analog_if.settings["{{port}}_{{index}}$SampleRate"].atoreal() ; 
	always @(analog_if.settings["{{port}}_{{index}}$Enable"]) analog_adrive.{{port}}_{{index}}$Enable = analog_if.settings["{{port}}_{{index}}$Enable"].atoi() ; 
	{%- endfor%}{%else%}always @(analog_if.settings["{{port}}$Freq"]) analog_adrive.{{port}}$Freq = analog_if.settings["{{port}}$Freq"].atoreal(); 
	always @(analog_if.settings["{{port}}$Amp"]) analog_adrive.{{port}}$Amp = analog_if.settings["{{port}}$Amp"].atoreal();
	always @(analog_if.settings["{{port}}$SampleRate"]) analog_adrive.{{port}}$SampleRate = analog_if.settings["{{port}}$SampleRate"].atoreal(); 
	always @(analog_if.settings["{{port}}$Enable"]) analog_adrive.{{port}}$Enable = analog_if.settings["{{port}}$Enable"].atoi(); 
	{% endif %}{% endif %}{% endif %}{% endif %}{%endif%}{% endfor %}

endmodule