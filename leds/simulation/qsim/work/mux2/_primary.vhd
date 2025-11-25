library verilog;
use verilog.vl_types.all;
entity mux2 is
    port(
        c0              : in     vl_logic;
        c1              : in     vl_logic;
        sel             : in     vl_logic;
        y               : out    vl_logic
    );
end mux2;
