// this is a basic test.. 
// turns on power , biases , sets default registers and starts clocks
// it should pass if the clocks successfully start. 
class sanity_test extends {{blocks['dut']['name']}}_test_base;
    `uvm_component_utils(sanity_test)
    extern function new(string name="sanity_test", uvm_component parent = null);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);

endclass: sanity_test


function sanity_test::new(string name = "sanity_test", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build the env, create the env configuration
// including any sub configurations and assigning virtural interfaces
// observers and manipulators
function void sanity_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction: build_phase

task sanity_test::run_phase(uvm_phase phase);
  power_on_seq power_on = power_on_seq::type_id::create("power_on");
  bias_on_seq bias_on = bias_on_seq::type_id::create("bias_on");
  start_clocks_seq start_clocks = start_clocks_seq::type_id::create("start_clocks");
  register_defaults_seq register_defaults = register_defaults_seq::type_id::create("register_defaults"); 
  {%if tests %}{% if tests['sanity_test']['sequences'] is defined %}{%for seq in tests['sanity_test']['sequences'] %}{{seq}}_seq {{seq}} = {{seq}}_seq::type_id::create("{{seq}}");
  {%endfor%}{%endif%}{%endif%}
  //fc_done_seq fc_done = fc_done_seq::type_id::create("fc_done");
  //reset_done_seq reset_done = reset_done_seq::type_id::create("reset_done");
  //ilpll_set_freq_seq set_freq = ilpll_set_freq_seq::type_id::create("set_freq");
  //
  // example of vseq.
  //
  //cal_ilpll_vco_coarse_code vco_coarse_cal = cal_ilpll_vco_coarse_code::type_id::create("vco_coarse_cal");
  //set_seqs(vco_coarse_cal);

  phase.raise_objection(this, "sanity_test");
  fork 
    register_defaults.start(m_env.v_sqr.register_sqr);
    power_on.start(m_env.v_sqr.power_sqr);
    bias_on.start(m_env.v_sqr.bias_sqr);
  join
  // the rest is up to the test
  
  start_clocks.start(m_env.v_sqr.digital_sqr);
  {%if tests %}{% if tests['sanity_test']['sequences'] %}{%for seq,sqr in tests['sanity_test']['sequences'].items() %}#2us {{seq}}.start(m_env.v_sqr.{{sqr}}_sqr);
  {%endfor%}{%endif%}{% if tests.get('sanity_test') %}{{tests['sanity_test']['body']|default('')}}
  {% endif %}{% endif %}
  //fc_done.start(m_env.v_sqr.register_sqr);
  //#40us
  #100ns;
  phase.drop_objection(this, "sanity_test");
endtask: run_phase

