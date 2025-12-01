library verilog;
use verilog.vl_types.all;
entity muxgrande_vlg_sample_tst is
    port(
        led0a           : in     vl_logic_vector(23 downto 0);
        led1a           : in     vl_logic_vector(23 downto 0);
        led2a           : in     vl_logic_vector(23 downto 0);
        led3a           : in     vl_logic_vector(23 downto 0);
        led4a           : in     vl_logic_vector(23 downto 0);
        led5a           : in     vl_logic_vector(23 downto 0);
        led6a           : in     vl_logic_vector(23 downto 0);
        led7a           : in     vl_logic_vector(23 downto 0);
        led8a           : in     vl_logic_vector(23 downto 0);
        led9a           : in     vl_logic_vector(23 downto 0);
        led10a          : in     vl_logic_vector(23 downto 0);
        led11a          : in     vl_logic_vector(23 downto 0);
        led12a          : in     vl_logic_vector(23 downto 0);
        led13a          : in     vl_logic_vector(23 downto 0);
        led14a          : in     vl_logic_vector(23 downto 0);
        led15a          : in     vl_logic_vector(23 downto 0);
        sampler_tx      : out    vl_logic
    );
end muxgrande_vlg_sample_tst;
