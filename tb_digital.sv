//SystemVerilog HDL for "{{library_name}}", "{{name}}" "svlog"
// auto generated digital top
`timescale 1ns/1ps
module {{ name }} ( {% set comma=joiner(', ') %}{% for port,portitem in ports.items()  %}{{ comma() }}
	{{portitem['dir']}} logic {%if portitem['msb'] %}[{{portitem['msb']}}:{{portitem['lsb']}}]{%else%} 	{%endif%} 	{{port}} {% endfor %}
);


// instantiate digital if
import uvm_pkg::uvm_config_db;
autb_generic_if digital_if(); // interface contains  associative array of string with string index : string settings[string].
// if uvm , register if with config 
initial begin 
	uvm_config_db#(virtual autb_generic_if)::set(null, "uvm_test_top", "digital_vif", digital_if);
end
// insert digital behavior here:
{% for port,portitem in ports.items()  %}{%if portitem['digital_type'] in ['clock'] %}real {{port}}$freq ;
{%if portitem['dir'] in ['output'] %}// drive clock {{port}} at frequency
	bit {{port}}$enable;
	bit {{port}}$clk;
	real {{port}}$Thalf_ns;
	always_comb 
		if({{port}}$freq>0) {{port}}$Thalf_ns = 0.5e9/{{port}}$freq;
		else {{port}}$Thalf_ns = 0;
	always wait({{port}}$enable &&({{port}}$Thalf_ns>0.01)) #({{port}}$Thalf_ns*1ns) {{port}}$clk = {{port}}$clk !== 1;
	assign {{port}} = {{port}}$clk;
	always @(digital_if.settings["{{port}}$freq"]) {{port}}$freq = digital_if.settings["{{port}}$freq"].atoreal();
	always @(digital_if.settings["{{port}}$enable"]) {{port}}$enable = digital_if.settings["{{port}}$enable"].atoi();
	{% if portitem.get('digital_info') and portitem['digital_info'].get('has_pair') %}assign {{portitem['digital_info']['has_pair']}} = ~{{port}}$clk;
{% endif %}
{% else %}//  measure clock frequency for {{port}}
	real {{port}}$tlast;
	string {{port}}$s_freq;
   	always  @(posedge {{port}}) begin
        if ({{port}}$tlast>0)  begin
			{{port}}$freq = 1e9/($realtime()-{{port}}$tlast);
			{{port}}$s_freq.realtoa({{port}}$freq);
    	end
    	{{port}}$tlast = $realtime();
   end
   task reset_{{port}}$meas();
    	begin
      		{{port}}$freq = 0;
      		{{port}}$tlast = 0;
    	end
  	endtask
  	always @(digital_if.settings["reset_{{port}}$meas"]) if (digital_if.settings["reset_{{port}}$meas"].atoi()) reset_{{port}}$meas();
  	always @({{port}}$s_freq) digital_if.observations["{{port}}$freq"] = {{port}}$s_freq;
{%endif%}{%endif%}{%endfor%}
endmodule