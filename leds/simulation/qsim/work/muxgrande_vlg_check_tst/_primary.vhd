library verilog;
use verilog.vl_types.all;
entity muxgrande_vlg_check_tst is
    port(
        y               : in     vl_logic_vector(383 downto 0);
        sampler_rx      : in     vl_logic
    );
end muxgrande_vlg_check_tst;
