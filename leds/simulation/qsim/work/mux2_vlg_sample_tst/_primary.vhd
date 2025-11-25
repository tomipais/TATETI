library verilog;
use verilog.vl_types.all;
entity mux2_vlg_sample_tst is
    port(
        c0              : in     vl_logic;
        c1              : in     vl_logic;
        sel             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end mux2_vlg_sample_tst;
