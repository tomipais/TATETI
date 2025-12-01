library verilog;
use verilog.vl_types.all;
entity Block1 is
    port(
        \OUT\           : out    vl_logic;
        inclk0          : in     vl_logic;
        and1            : out    vl_logic;
        and2            : out    vl_logic;
        count           : out    vl_logic_vector(8 downto 0)
    );
end Block1;
