library verilog;
use verilog.vl_types.all;
entity Block1 is
    port(
        columna0        : out    vl_logic;
        reloj           : in     vl_logic;
        entrada0        : in     vl_logic;
        columna1        : out    vl_logic;
        entrada1        : in     vl_logic;
        columna2        : out    vl_logic;
        entrada2        : in     vl_logic;
        columna3        : out    vl_logic;
        entrada3        : in     vl_logic;
        pin_name1       : out    vl_logic;
        Posicion        : out    vl_logic_vector(3 downto 0);
        Z               : out    vl_logic_vector(0 to 3)
    );
end Block1;
