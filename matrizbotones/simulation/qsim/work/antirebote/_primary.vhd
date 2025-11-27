library verilog;
use verilog.vl_types.all;
entity antirebote is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        sw              : in     vl_logic;
        valido          : out    vl_logic
    );
end antirebote;
