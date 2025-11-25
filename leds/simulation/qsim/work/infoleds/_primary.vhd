library verilog;
use verilog.vl_types.all;
entity infoleds is
    port(
        reset           : in     vl_logic;
        clock           : in     vl_logic;
        c0              : in     vl_logic;
        c1              : in     vl_logic;
        senal           : out    vl_logic
    );
end infoleds;
