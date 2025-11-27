library verilog;
use verilog.vl_types.all;
entity contador2000 is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        q               : out    vl_logic_vector(9 downto 0);
        T               : out    vl_logic
    );
end contador2000;
