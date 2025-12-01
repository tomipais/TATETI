library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity salidaserie is
    port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        enable  : in  std_logic;
        load    : in  std_logic;
        data_in : in  std_logic_vector(383 downto 0);
        sr_out  : out std_logic
    );
end entity;

architecture rtl of salidaserie is

    signal sr : std_logic_vector(383 downto 0);

begin

    process(clk, reset)
    begin
        if reset = '1' then
            sr <= (others => '0');

        elsif rising_edge(clk) then

            if load = '1' then
                sr <= data_in;  -- Cargo los 384 bits

            elsif enable = '1' then
                sr <= '0' & sr(383 downto 1); -- Desplazo hacia derecha
            end if;

        end if;
    end process;

    sr_out <= sr(0); -- Sale el bit menos significativo primero

end rtl;
