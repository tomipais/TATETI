library verilog;
use verilog.vl_types.all;
entity Block1_vlg_check_tst is
    port(
        and1            : in     vl_logic;
        and2            : in     vl_logic;
        count           : in     vl_logic_vector(8 downto 0);
        \OUT\           : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end Block1_vlg_check_tst;
