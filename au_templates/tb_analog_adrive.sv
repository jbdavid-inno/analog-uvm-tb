//SystemVerilog RNM HDL for "{{library_name}}", "{{name}}_adrive" "svrnm"

// auto generated bias top
module {{ name }}_adrive ( {% set comma=joiner(', ') %}{% for port,portitem in ports.items()  %}{{ comma() }}
	{{portitem['dir']}} {%if portitem['msb'] %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%else%} 	{%endif%} 	{{port}} {% endfor %}
);
// declarations for ports signals
{% for port,portitem in ports.items() %} interconnect{% if portitem.msb %} [{{portitem['msb']}}:{{portitem['lsb']}}] {%else%}	{%endif%}{{port}};
{% endfor %}
// var declarations for DE signal ports
{% for port,portitem in ports.items() %}real {{port}}$Vobs{% if portitem.msb %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%endif%}, {{port}}$Iobs{% if portitem.msb %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%endif%}, {{port}}{% if portitem['dir'] in ['input'] %}$Idrv{%else%}$Vdrv{%endif%}{% if portitem.msb %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%endif%}, {{port}}{% if portitem['dir'] in ['input'] %}$Gdrv{%else%}$Rdrv{%endif%}{% if portitem.msb %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%endif%};
{% endfor %}

// UDN instantiation for DE signal ports
{% for port,portitem in ports.items() %}DE_{% if portitem['dir'] in ['input'] %}norton{%else%}thevenin{%endif%} Xtcvr_{{port}}{% if portitem.msb %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%endif%}( {{port}},{{port}}$Vobs, {{port}}$Iobs, {{port}}{% if portitem['dir'] in ['input'] %}$Idrv{%else%}$Vdrv{%endif%}, {{port}}{% if portitem['dir'] in ['input'] %}$Gdrv{%else%}$Rdrv{%endif%} );
{% endfor %}
//pi
const real pi = $acos(-1);
// variables for the digital context
reg sample_trigger = 0;
//the only thing we'll start with is monitoring input voltages
{% for port,portitem in ports.items() %}{% if portitem['dir'] in ['input'] %}{% if portitem.msb %}{%for index in range(portitem[lsb],portitem[msb]+1) %}real {{port}}_{{index}}_volts;
{% endfor %}{%else%}real {{port}}_volts;
{% endif %}{% elif portitem['dir'] in ['output'] %}{% if portitem.get('analog_info') and portitem['analog_info']['wavetype'] in ['dc'] %}{%if portitem['msb'] %}
{%- for index in range(portitem[lsb],portitem[msb]+1) %}real {{port}}_{{index}}$Vset; string {{port}}_{{index}}$Vset$string;
{%- endfor %}{%else%}real {{port}}$Vset;  
{%- endif %}{% elif portitem.get('analog_info') and portitem['analog_info']['wavetype'] in ['rfsine']  -%}
{%- if portitem['analog_info'].get('pair_name') %}{%if portitem['msb'] %}
{%- for index in range(portitem[lsb],portitem[msb]+1) %}real {{portitem['analog_info']['pair_name']}}_{{index}}$Freq; 
real {{portitem['analog_info']['pair_name']}}_{{index}}$Amp;              
real {{portitem['analog_info']['pair_name']}}_{{index}}$SampleRate;       
bit {{portitem['analog_info']['pair_name']}}_{{index}}$Enable;
real {{portitem['analog_info']['pair_name']}}_{{index}}$Tsample, {{portitem['analog_info']['pair_name']}}_{{index}}$phase ;
real {{portitem['analog_info']['pair_name']}}_{{index}}$Isig,{{portitem['analog_info']['pair_name']}}_{{index}}$Qsig;
{%- endfor%}{%else%}real {{portitem['analog_info']['pair_name']}}$Freq; 
real {{portitem['analog_info']['pair_name']}}$Amp;
real {{portitem['analog_info']['pair_name']}}$SampleRate;
bit {{portitem['analog_info']['pair_name']}}$Enable;
real {{portitem['analog_info']['pair_name']}}$Tsample, {{portitem['analog_info']['pair_name']}}$phase ;
real {{portitem['analog_info']['pair_name']}}$Isig,{{portitem['analog_info']['pair_name']}}$Qsig;
{%- endif%}{%else%}{%if portitem['msb'] %}
{%- for index in range(portitem[lsb],portitem[msb]+1) %}real {{port}}_{{index}}$Freq;
real {{port}}_{{index}}$Amp;
real {{port}}_{{index}}$SampleRate;
bit {{port}}_{{index}}$Enable;
real {{port}}_{{index}}$Tsample, {{port}}_{{index}}$phase ;
real {{port}}_{{index}}$Isig, {{port}}_{{index}}$Qsig;
{%- endfor%}{%else%}real {{port}}$Freq;
real {{port}}$Amp;
real {{port}}$SampleRate;
bit {{port}}$Enable;
real {{port}}$Tsample, {{port}}$phase ;
real {{port}}$Isig, {{port}}$Qsig;
{% endif %}{% endif %}
{% endif %}{% endif %}{% endfor %}
// rest  need to write by hand based on design needs
{% for port,portitem in ports.items() %}{% if portitem['dir'] == 'input' %}{%if portitem['msb'] %}{%for index in range(portitem[lsb],portitem[msb]+1) %}always_comb {{port}}_{{index}}_volts) ={{port}}$Vobs[{{index}}]_volts"].realtoa(analog_adrive.{{port}}_{{index}}_volts) ;
{%endfor%}{%else%}always_comb {{port}}_volts = {{port}}$Vobs ;
{% endif %}{% elif portitem['dir'] in ['output'] %}{% if portitem.get('analog_info') and portitem['analog_info']['wavetype'] in ['dc'] %}{%if portitem['msb'] %}
{%- for index in range(portitem[lsb],portitem[msb]+1) %}// dc source
always_comb {{port}}$Vdrv[{{index}}] = {{port}}_{{index}}$Vset; 
{%- endfor %}{%else%}// dc source
always_comb {{port}}$Vdrv = {{port}}$Vset;  
{%- endif %}{% elif portitem.get('analog_info') and portitem['analog_info']['wavetype'] in ['rfsine']  -%}
{%- if portitem['analog_info'].get('pair_name') %}{%if portitem['msb'] %}
{%- for index in range(portitem[lsb],portitem[msb]+1) %}// rfsine 
always_comb if ({{portitem['analog_info']['pair_name']}}_{{index}}$SampleRate> 1e6) {{portitem['analog_info']['pair_name']}}_{{index}}$Tsample = 1ns*1e9/{{portitem['analog_info']['pair_name']}}_{{index}}$SampleRate;
always wait({{portitem['analog_info']['pair_name']}}_{{index}}$Enable && {{portitem['analog_info']['pair_name']}}_{{index}}$SampleRate > 1e6 && {{portitem['analog_info']['pair_name']}}_{{index}}$Tsample>1ps) begin
	{{portitem['analog_info']['pair_name']}}_{{index}}$phase += {{portitem['analog_info']['pair_name']}}$Freq/{{portitem['analog_info']['pair_name']}}_{{index}}$SampleRate;
	{{portitem['analog_info']['pair_name']}}_{{index}}$phase -= $itor($floor({{portitem['analog_info']['pair_name']}}_{{index}}$phase));// keep phase in range of 0 to 1 
	{{portitem['analog_info']['pair_name']}}_{{index}}$Isig = $cos(2.0*pi*{{portitem['analog_info']['pair_name']}}_{{index}}$phase)*{{portitem['analog_info']['pair_name']}}_{{index}}$Amp*$itor({{portitem['analog_info']['pair_name']}}_{{index}}$Enable);
	{{portitem['analog_info']['pair_name']}}_{{index}}$Qsig = $cos(2.0*pi*({{portitem['analog_info']['pair_name']}}_{{index}}$phase -0.25))*{{portitem['analog_info']['pair_name']}}_{{index}}$Amp*$itor({{portitem['analog_info']['pair_name']}}_{{index}}$Enable);
	#{{portitem['analog_info']['pair_name']}}_{{index}}$Tsample;
end  
always_comb if({{portitem['analog_info']['pair_name']}}_{{index}}$Enable) {{portitem['analog_info']['has_pair']}}$Vdrv = {{portitem['analog_info']['pair_name']}}_{{index}}$Isig;
			else {{portitem['analog_info']['has_pair']}}_{{index}}$Vdrv = 0;
always_comb if({{portitem['analog_info']['pair_name']}}_{{index}}$Enable) {{port}}_{{index}}$Vdrv = {{portitem['analog_info']['pair_name']}}_{{index}}$Qsig;
			else {{port}}_{{index}}$Vdrv = 0;
{%- endfor%}{%else%}// rfsine 
always_comb if ({{portitem['analog_info']['pair_name']}}$SampleRate> 1e6) {{portitem['analog_info']['pair_name']}}$Tsample = 1ns*1e9/{{portitem['analog_info']['pair_name']}}$SampleRate;
always wait({{portitem['analog_info']['pair_name']}}$Enable && {{portitem['analog_info']['pair_name']}}$SampleRate > 1e6 && {{portitem['analog_info']['pair_name']}}$Tsample>1ps) begin
	{{portitem['analog_info']['pair_name']}}$phase += {{portitem['analog_info']['pair_name']}}$Freq/{{portitem['analog_info']['pair_name']}}$SampleRate;
	{{portitem['analog_info']['pair_name']}}$phase -= $itor($floor({{portitem['analog_info']['pair_name']}}$phase));// keep phase in range of 0 to 1 
	{{portitem['analog_info']['pair_name']}}$Isig = $cos(2.0*pi*{{portitem['analog_info']['pair_name']}}$phase)*{{portitem['analog_info']['pair_name']}}$Amp*$itor({{portitem['analog_info']['pair_name']}}$Enable);
	{{portitem['analog_info']['pair_name']}}$Qsig = $cos(2.0*pi*({{portitem['analog_info']['pair_name']}}$phase -0.25))*{{portitem['analog_info']['pair_name']}}$Amp*$itor({{portitem['analog_info']['pair_name']}}$Enable);
	#{{portitem['analog_info']['pair_name']}}$Tsample;
end  
always_comb if({{portitem['analog_info']['pair_name']}}$Enable) {{portitem['analog_info']['has_pair']}}$Vdrv = {{portitem['analog_info']['pair_name']}}$Isig;
			else {{portitem['analog_info']['has_pair']}}$Vdrv = 0;
always_comb if({{portitem['analog_info']['pair_name']}}$Enable) {{port}}$Vdrv = {{portitem['analog_info']['pair_name']}}$Qsig;
			else {{port}}$Vdrv = 0;
{%- endif%}{%else%}{%if portitem['msb'] %}
{%- for index in range(portitem[lsb],portitem[msb]+1) %}// rfsine 
always_comb if ({{port}}_{{index}}$SampleRate> 1e6) {{port}}_{{index}}$Tsample = 1ns*1e9/{{port}}_{{index}}$SampleRate;
always wait({{port}}_{{index}}$Enable && {{port}}_{{index}}$SampleRate > 1e6 && {{port}}_{{index}}$Tsample>1ps) begin
	{{port}}_{{index}}$phase += {{port}}_{{index}}$Freq/{{port}}_{{index}}$SampleRate;
	{{port}}_{{index}}$phase -= $itor($floor({{port}}_{{index}}$phase));// keep phase in range of 0 to 1 
	{{port}}_{{index}}$Isig = $cos(2.0*pi*{{port}}_{{index}}$phase)*{{port}}_{{index}}$Amp*$itor({{port}}_{{index}}$Enable);
	{{port}}_{{index}}$Qsig = $cos(2.0*pi*({{port}}_{{index}}$phase -0.25))*{{port}}_{{index}}$Amp*$itor({{port}}_{{index}}$Enable);
	#{{port}}_{{index}}$Tsample;
end  
always_comb if({{port}}_{{index}}$Enable) {{port}}_{{index}}$Vdrv = {{port}}_{{index}}$Qsig;
			else {{port}}_{{index}}$Vdrv = 0;
{%- endfor%}{%else%}// rfsine 
always_comb if ({{port}}$SampleRate> 1e6) {{port}}$Tsample = 1ns*1e9/{{port}}$SampleRate;
always wait({{port}}$Enable && {{port}}$SampleRate > 1e6 && {{port}}$Tsample>1ps) begin
	{{port}}$phase += {{port}}$Freq/{{port}}$SampleRate;
	{{port}}$phase -= $itor($floor({{port}}$phase));// keep phase in range of 0 to 1 
	{{port}}$Isig = $cos(2.0*pi*{{port}}$phase)*{{port}}$Amp*$itor({{port}}$Enable);
	{{port}}$Qsig = $cos(2.0*pi*({{port}}$phase -0.25))*{{port}}$Amp*$itor({{port}}$Enable);
	#{{port}}$Tsample;
end  
always_comb if({{port}}$Enable) {{port}}$Vdrv = {{port}}$Qsig;
			else {{port}}$Vdrv = 0;
{% endif %}{% endif %}
{% endif %}{% endif %}{% endfor %}
// dc sources

endmodule