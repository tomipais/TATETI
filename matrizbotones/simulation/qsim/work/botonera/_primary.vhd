library verilog;
use verilog.vl_types.all;
entity botonera is
    port(
        reset           : in     vl_logic;
        clock           : in     vl_logic;
        x0              : in     vl_logic;
        x1              : in     vl_logic;
        x2              : in     vl_logic;
        x3              : in     vl_logic;
        Z               : out    vl_logic_vector(0 to 3)
    );
end botonera;
