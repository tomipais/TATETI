library verilog;
use verilog.vl_types.all;
entity bloqueador is
    port(
        reset           : in     vl_logic;
        clock           : in     vl_logic;
        c0              : in     vl_logic;
        c1              : in     vl_logic;
        c2              : in     vl_logic;
        c3              : in     vl_logic;
        sal0            : out    vl_logic;
        sa1             : out    vl_logic;
        sal2            : out    vl_logic;
        sal3            : out    vl_logic
    );
end bloqueador;
