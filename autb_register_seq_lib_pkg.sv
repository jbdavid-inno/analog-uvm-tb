package {{blocks['dut']['name']}}_register_seq_lib_pkg;
    import uvm_pkg::*;
    import autb_csr_agent_pkg::*;
    `include "register_defaults_seq.svh"
{%for blockid in blocks['register']['reg_blocks'].keys()%}
    `include "{{blockid}}_on_seq.svh"
{% endfor%}
endpackage: {{blocks['dut']['name']}}_register_seq_lib_pkg
