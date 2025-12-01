library verilog;
use verilog.vl_types.all;
entity contador_384_vlg_check_tst is
    port(
        count           : in     vl_logic_vector(8 downto 0);
        done            : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end contador_384_vlg_check_tst;
