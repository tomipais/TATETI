library verilog;
use verilog.vl_types.all;
entity antirebote_vlg_check_tst is
    port(
        valido          : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end antirebote_vlg_check_tst;
