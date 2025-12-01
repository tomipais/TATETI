library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador_384 is
    port (
        clk    : in  std_logic;
        reset  : in  std_logic;
        enable : in  std_logic;            -- Pulso de inicio del barrido
        count  : out unsigned(8 downto 0); -- 0..383
        done   : out std_logic             -- Se activa cuando termina
    );
end entity;

architecture comportamiento of contador_384 is
    signal cnt : unsigned(8 downto 0) := (others => '0');
    signal activo : std_logic := '0';
begin

    process (clk, reset)
    begin
        if reset = '1' then
            cnt <= (others => '0');
            activo <= '0';
        elsif rising_edge(clk) then

            -- Habilita un nuevo barrido cuando enable pasa a '1'
            if enable = '1' and cnt /= 383 then
                activo <= '1';
            end if;

            if activo = '1' then
                if cnt = 383 then
                    --cnt <= (others => '0');  -- vuelve a 0
                    activo <= '0'; -- se detiene
                else
                    cnt <= cnt + 1;
                end if;
            end if;
        end if;
    end process;

    count <= cnt;
    done <= '1' when (activo = '0' and cnt = 383) else '0';



end comportamiento;
