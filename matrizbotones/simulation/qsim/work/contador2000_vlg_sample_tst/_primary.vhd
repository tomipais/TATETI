library verilog;
use verilog.vl_types.all;
entity contador2000_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        enable          : in     vl_logic;
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end contador2000_vlg_sample_tst;
