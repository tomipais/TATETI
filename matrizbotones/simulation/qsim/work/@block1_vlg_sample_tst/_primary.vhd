library verilog;
use verilog.vl_types.all;
entity Block1_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        pin_name1       : in     vl_logic;
        x0              : in     vl_logic;
        x1              : in     vl_logic;
        x2              : in     vl_logic;
        x3              : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end Block1_vlg_sample_tst;
