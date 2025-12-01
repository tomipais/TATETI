library verilog;
use verilog.vl_types.all;
entity salidaserie is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        load            : in     vl_logic;
        data_in         : in     vl_logic_vector(383 downto 0);
        sr_out          : out    vl_logic
    );
end salidaserie;
