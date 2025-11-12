library verilog;
use verilog.vl_types.all;
entity Block1_vlg_check_tst is
    port(
        columna0        : in     vl_logic;
        columna1        : in     vl_logic;
        columna2        : in     vl_logic;
        columna3        : in     vl_logic;
        pin_name1       : in     vl_logic;
        Posicion        : in     vl_logic_vector(3 downto 0);
        Z               : in     vl_logic_vector(0 to 3);
        sampler_rx      : in     vl_logic
    );
end Block1_vlg_check_tst;
