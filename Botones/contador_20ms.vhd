library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Necesario para la aritmética

entity contador_20ms is
    Port ( 
        clk_50mhz : in  STD_LOGIC; -- Reloj de entrada de 50 MHz
        reset     : in  STD_LOGIC; -- Reset asíncrono (o síncrono, según prefieras)
        tick_20ms : out STD_LOGIC  -- Pulso de salida cada 20ms
    );
end entity contador_20ms;

architecture Behavioral of contador_20ms is

    -- Cálculo:
    -- Frecuencia = 50,000,000 Hz (ciclos por segundo)
    -- Tiempo deseado = 0.020 segundos (20 ms)
    -- Ciclos necesarios = 50,000,000 * 0.020 = 1,000,000 ciclos.
    
    -- Contaremos de 0 a 999,999 (que son 1,000,000 de ciclos)
    constant MAX_COUNT : integer := 999999;
    
    -- Señal interna para llevar la cuenta
    signal count_reg : integer range 0 to MAX_COUNT;

begin

    -- Proceso principal síncrono
    process(clk_50mhz, reset)
    begin
        -- Reset asíncrono
        if reset = '1' then
            count_reg <= 0;
            tick_20ms <= '0';
            
        -- Lógica síncrona en el flanco de subida del reloj
        elsif rising_edge(clk_50mhz) then
            
            -- Por defecto, el tick está en bajo
            tick_20ms <= '0'; 
            
            -- Comprobar si llegamos al final de la cuenta
            if count_reg = MAX_COUNT then
                count_reg <= 0;      -- Reiniciar el contador
                tick_20ms <= '1';  -- Generar el pulso de 'tick' por 1 ciclo
            else
                count_reg <= count_reg + 1; -- Incrementar el contador
            end if;
            
        end if;
    end process;

end architecture Behavioral;