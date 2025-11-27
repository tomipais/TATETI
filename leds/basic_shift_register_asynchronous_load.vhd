library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity basic_shift_register_asynchronous_load is
    generic(
        NUM_STAGES : natural := 384
    );
    port(
        clk     : in std_logic;
        enable  : in std_logic;
        entrada : in std_logic_vector(NUM_STAGES-1 downto 0);
        load    : in std_logic;
        sr_out  : out std_logic
    );
end entity;

architecture rtl of basic_shift_register_asynchronous_load is

    signal sr : std_logic_vector(NUM_STAGES-1 downto 0);

begin

    process(clk, load)
    begin
        if (load = '1') then
            sr <= entrada;  -- Carga paralela
        elsif rising_edge(clk) then
            if enable = '1' then
                sr(NUM_STAGES-1 downto 1) <= sr(NUM_STAGES-2 downto 0); -- Shift
                sr(0) <= '0';  -- dato nuevo (si querés, puedo hacer que entre por un pin)
            end if;
        end if;
    end process;

    sr_out <= sr(NUM_STAGES-1);  -- Bit serial de salida

end rtl;

