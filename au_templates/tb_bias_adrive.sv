//SystemVerilog RNM HDL for "{{library_name}}", "{{name}}_adrive" "svrnm"

// auto generated bias top
module {{ name }}_adrive ( {% set comma=joiner(', ') %}{% for port,portitem in ports.items()  %}{{ comma() }}
	{{portitem['dir']}} interconnect {%if portitem['msb'] %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%else%} 	{%endif%} 	{{port}} {% endfor %}
);
// var declarations for DE signal ports
//real rxadc_ldo_avdd$Vobs, rxadc_ldo_avdd$Iobs, rxadc_ldo_avdd$Vdrv, rxadc_ldo_avdd$Rdrv;
{% for port,portitem in ports.items() %}real {{port}}$Vobs{% if portitem.msb %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%endif%}, {{port}}$Iobs{% if portitem.msb %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%endif%}, {{port}}$Idrv{% if portitem.msb %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%endif%}, {{port}}$Gdrv{% if portitem.msb %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%endif%};
{% endfor %}

// UDN instantiation for DE signal ports
{% for port,portitem in ports.items() %}DE_norton Xtcvr_{{port}}{% if portitem.msb %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%endif%}( {{port}},{{port}}$Vobs, {{port}}$Iobs, {{port}}$Idrv, {{port}}$Gdrv);
{% endfor %}
// variables for the digital context
// declarations for supply voltage variables. (assuming all are currents) //this is the variable set when the biase current changes
{% for port,portitem in ports.items() %}{%if portitem['dir'] in ['input']%}{%else%}{% if portitem.msb %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1,1) %} real {{port}}_{%if portitem['bias_type'] in ['current']%}i{%else%}v{%endif%}set_{{index}} ;
{% endfor %}{% else %}real {{port}}_{%if portitem['bias_type'] in ['current']%}i{%else%}v{%endif%}set";
{%endif%}{%endif%}{% endfor %}
// declarations for supply enable variables. (assuming all are voltages)// when set to 1 the resistance is changed from roff to ron (logarithmically)
{% for port,portitem in ports.items() %}{%if portitem['supply_type'] in ['gnd']%}{%else%}{% if portitem.msb %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1,1) %} bit {{port}}_enable_{{index}} ;
{% endfor %}{% else %}bit {{port}}_enable;
{%endif%}{%endif%}{% endfor %}
// declarations for supply rout variables. (assuming all are voltages) - dont use array variable for easier plotting 
{% for port,portitem in ports.items() %}{%if portitem['supply_type'] in ['gnd']%}{%else%}{% if portitem.msb %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1,1) %} real {{port}}_roff_{{index}} = 10K;
{% endfor %}{% else %}real {{port}}_roff = 10K;
{%endif%}{%endif%}{% endfor %}
{% for port,portitem in ports.items() %}{%if portitem['supply_type'] in ['gnd']%}{%else%}{% if portitem.msb %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1,1) %} real {{port}}_ron_{{index}} = 10;
{% endfor %}{% else %}real {{port}}_ron = 0.1;
{%endif%}{%endif%}{% endfor %}
{% for port,portitem in ports.items() %}{%if portitem['supply_type'] in ['volts']%}{% if portitem.msb %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1,1) %} always_comb 
	if ({{port}}_enable_{{index}}) begin
		{{port}}$Vdrv[{{index}}] = {{port}}_vset_{{index}};
		{{port}}$Rdrv[{{index}}] = {{port}}_ron_{{index}};
	end else begin
		{{port}}$Vdrv[{{index}}] = 0.0;
		{{port}}$Rdrv[{{index}}] = {{port}}_roff_{{index}};
	end
{% endfor %}{% else %}always_comb 
	if ({{port}}_enable) begin
		{{port}}$Vdrv = {{port}}_vset;
		{{port}}$Rdrv = {{port}}_ron;
	end	else begin 
		{{port}}$Vdrv = 0.0;
		{{port}}$Rdrv = {{port}}_roff;
	end
{%endif%}{%endif%}{% endfor %}
{% if ports %}
initial begin
{% for port,portitem in ports.items() %}{%if portitem['supply_type'] in ['gnd']%}{% if portitem.msb %}{%for index in range(portitem['lsb']|int,portitem['msb']|int+1,1) %}  {{port}}$Vdrv[{{index}}] = 0.0;
{% endfor %}{% else %}{{port}}$Vdrv = 0.0;
{%endif%}{%endif%}{% endfor %}
end
{%endif%}


endmodule