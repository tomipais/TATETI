library verilog;
use verilog.vl_types.all;
entity tateti is
    port(
        reset           : in     vl_logic;
        clock           : in     vl_logic;
        x               : in     vl_logic;
        T               : in     vl_logic;
        z               : out    vl_logic;
        cont            : out    vl_logic
    );
end tateti;
