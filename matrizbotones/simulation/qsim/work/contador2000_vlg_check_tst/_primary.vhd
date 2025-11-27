library verilog;
use verilog.vl_types.all;
entity contador2000_vlg_check_tst is
    port(
        q               : in     vl_logic_vector(9 downto 0);
        T               : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end contador2000_vlg_check_tst;
