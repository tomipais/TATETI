library verilog;
use verilog.vl_types.all;
entity Block1_vlg_sample_tst is
    port(
        entrada0        : in     vl_logic;
        entrada1        : in     vl_logic;
        entrada2        : in     vl_logic;
        entrada3        : in     vl_logic;
        reloj           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end Block1_vlg_sample_tst;
