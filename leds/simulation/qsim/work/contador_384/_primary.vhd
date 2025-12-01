library verilog;
use verilog.vl_types.all;
entity contador_384 is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        count           : out    vl_logic_vector(8 downto 0);
        done            : out    vl_logic
    );
end contador_384;
