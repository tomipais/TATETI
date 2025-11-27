library verilog;
use verilog.vl_types.all;
entity botonera_vlg_check_tst is
    port(
        Z               : in     vl_logic_vector(0 to 3);
        sampler_rx      : in     vl_logic
    );
end botonera_vlg_check_tst;
