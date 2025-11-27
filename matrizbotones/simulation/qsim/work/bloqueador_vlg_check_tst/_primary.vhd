library verilog;
use verilog.vl_types.all;
entity bloqueador_vlg_check_tst is
    port(
        sa1             : in     vl_logic;
        sal0            : in     vl_logic;
        sal2            : in     vl_logic;
        sal3            : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end bloqueador_vlg_check_tst;
