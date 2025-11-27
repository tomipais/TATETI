library verilog;
use verilog.vl_types.all;
entity Block1 is
    port(
        c0              : out    vl_logic;
        clk             : in     vl_logic;
        x0              : in     vl_logic;
        x1              : in     vl_logic;
        x3              : in     vl_logic;
        x2              : in     vl_logic;
        c1              : out    vl_logic;
        c2              : out    vl_logic;
        c3              : out    vl_logic;
        z0              : out    vl_logic;
        z1              : out    vl_logic;
        z2              : out    vl_logic;
        z3              : out    vl_logic;
        p0              : out    vl_logic;
        p1              : out    vl_logic;
        p2              : out    vl_logic;
        p3              : out    vl_logic;
        c4              : out    vl_logic;
        locked          : out    vl_logic;
        T               : out    vl_logic;
        cont            : out    vl_logic
    );
end Block1;
