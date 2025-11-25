library verilog;
use verilog.vl_types.all;
entity infoleds_vlg_sample_tst is
    port(
        c0              : in     vl_logic;
        c1              : in     vl_logic;
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end infoleds_vlg_sample_tst;
