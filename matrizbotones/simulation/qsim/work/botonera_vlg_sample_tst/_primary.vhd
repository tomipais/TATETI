library verilog;
use verilog.vl_types.all;
entity botonera_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        x0              : in     vl_logic;
        x1              : in     vl_logic;
        x2              : in     vl_logic;
        x3              : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end botonera_vlg_sample_tst;
