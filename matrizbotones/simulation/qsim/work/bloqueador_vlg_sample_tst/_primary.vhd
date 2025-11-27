library verilog;
use verilog.vl_types.all;
entity bloqueador_vlg_sample_tst is
    port(
        c0              : in     vl_logic;
        c1              : in     vl_logic;
        c2              : in     vl_logic;
        c3              : in     vl_logic;
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end bloqueador_vlg_sample_tst;
