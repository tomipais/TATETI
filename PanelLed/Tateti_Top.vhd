LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Tateti_Top IS
    PORT (
        -- === Entradas Físicas ===
        -- Esta es la entrada del oscilador de tu placa (ej: 25 MHz, 50 MHz, etc.)
        clk_in   : IN STD_LOGIC; 
        reset_in : IN STD_LOGIC; -- Botón de reset físico (activo alto)
        
        -- Aquí van tus botones físicos
        btn_new_game_in : IN STD_LOGIC;
        btn_move_pos_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        btn_move_valid_in : IN STD_LOGIC;

        -- === Salida Física ===
        led_serial_out_pin : OUT STD_LOGIC -- ¡El único pin para todos los LEDs!
    );
END ENTITY Tateti_Top;

ARCHITECTURE rtl OF Tateti_Top IS

    -- === Componente 0: El PLL (generado por el IP Catalog) ===
    -- NOTA: El nombre "mi_pll" debe coincidir con el que creaste en el wizard
    COMPONENT mi_pll IS
        PORT (
            inclk0 : IN  STD_LOGIC; -- Entrada de reloj (desde clk_in)
            c0     : OUT STD_LOGIC; -- Salida de reloj (nuestro 50 MHz)
            locked : OUT STD_LOGIC  -- '1' cuando el PLL está estable
        );
    END COMPONENT mi_pll;
    
    -- === Componente 1: Tu PanelLed (lógica de display) ===
    COMPONENT PanelLed IS
        GENERIC (
            G_CLK_FREQ      : INTEGER;
            G_BLINK_FREQ_HZ : INTEGER
        );
        PORT (
            clk               : IN STD_LOGIC;
            reset             : IN STD_LOGIC;
            new_game_start_in : IN STD_LOGIC;
            move_pos_in       : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            move_valid_in     : IN STD_LOGIC;
            score_p1_in       : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            score_p2_in       : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            game_state_in     : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            win_line_in       : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            led_data_out      : OUT STD_LOGIC_VECTOR(383 DOWNTO 0)
        );
    END COMPONENT PanelLed;

    -- === Componente 2: El Driver Serial (serializador) ===
    COMPONENT ws2812_driver IS
        GENERIC (
            G_CLK_FREQ  : INTEGER;
            G_LED_COUNT : INTEGER
        );
        PORT (
            clk              : IN STD_LOGIC;
            reset            : IN STD_LOGIC;
            parallel_data_in : IN STD_LOGIC_VECTOR(383 DOWNTO 0);
            start_transfer   : IN STD_LOGIC;
            busy_out         : OUT STD_LOGIC;
            led_serial_out   : OUT STD_LOGIC
        );
    END COMPONENT ws2812_driver;

    -- === Señales de Conexión Interna ===
    SIGNAL s_clk_50mhz      : STD_LOGIC; -- El reloj de 50MHz generado por el PLL
    SIGNAL s_pll_locked     : STD_LOGIC; -- Señal de "estable" del PLL
    SIGNAL s_global_reset   : STD_LOGIC; -- Reset global (sincronizado)
    
    SIGNAL s_panel_led_data : STD_LOGIC_VECTOR(383 DOWNTO 0);
    SIGNAL s_driver_busy    : STD_LOGIC;
    SIGNAL s_start_transfer : STD_LOGIC := '0';
    
    -- Generador de Refresco (50,000,000 / 60 Hz = 833,333 ciclos)
    CONSTANT C_REFRESH_PERIOD : INTEGER := 833_333; 
    SIGNAL s_refresh_counter  : INTEGER RANGE 0 TO C_REFRESH_PERIOD;

BEGIN

    -- 0. Instancia del PLL
    -- Conecta el reloj de la placa (clk_in) al PLL
    U0_PLL : mi_pll
    PORT MAP (
        inclk0 => clk_in,
        c0     => s_clk_50mhz, -- Genera nuestro reloj de 50 MHz
        locked => s_pll_locked
    );

    -- El reset global está activo si el botón de reset se presiona
    -- O si el PLL aún no está estable (locked).
    s_global_reset <= reset_in OR (NOT s_pll_locked); 

    -- 1. Instancia de tu lógica de Panel
    U1_PanelLed : PanelLed
    GENERIC MAP (
        G_CLK_FREQ      => 50_000_000, -- Usa el reloj del PLL
        G_BLINK_FREQ_HZ => 2
    )
    PORT MAP (
        clk               => s_clk_50mhz,    -- Conectado al PLL
        reset             => s_global_reset, -- Conectado al reset global
        new_game_start_in => btn_new_game_in,
        move_pos_in       => btn_move_pos_in,
        move_valid_in     => btn_move_valid_in,
        
        -- !!! IMPORTANTE: Estas son señales "dummy" !!!
        -- Debes reemplazarlas con la salida de tu FSM de juego real.
        score_p1_in       => "00", 
        score_p2_in       => "00",
        game_state_in     => "00", -- "En curso"
        win_line_in       => "000",
        
        led_data_out      => s_panel_led_data -- Salida al driver
    );

    -- 2. Instancia del Driver Serial
    U2_WS2812_Driver : ws2812_driver
    GENERIC MAP (
        G_CLK_FREQ  => 50_000_000, -- Usa el reloj del PLL
        G_LED_COUNT => 16
    )
    PORT MAP (
        clk              => s_clk_50mhz,    -- Conectado al PLL
        reset            => s_global_reset, -- Conectado al reset global
        parallel_data_in => s_panel_led_data, -- Entrada desde PanelLed
        start_transfer   => s_start_transfer, -- Desde el refresco
        busy_out         => s_driver_busy,
        led_serial_out   => led_serial_out_pin -- Salida al pin físico
    );
    
    -- 3. Proceso de Refresco (a ~60 Hz)
    -- Le dice al driver cuándo enviar el buffer de s_panel_led_data
    p_refresh_logic : PROCESS (s_clk_50mhz, s_global_reset)
    BEGIN
        IF (s_global_reset = '1') THEN
            s_refresh_counter <= 0;
            s_start_transfer  <= '0';
        ELSIF (rising_edge(s_clk_50mhz)) THEN
            s_start_transfer <= '0'; -- El pulso solo dura 1 ciclo
            
            IF (s_driver_busy = '0') THEN -- Solo refrescar si el driver está libre
                IF (s_refresh_counter = C_REFRESH_PERIOD - 1) THEN
                    s_refresh_counter <= 0;
                    s_start_transfer  <= '1'; -- ¡Iniciar transferencia!
                ELSE
                    s_refresh_counter <= s_refresh_counter + 1;
                END IF;
            ELSE
                s_refresh_counter <= 0; -- Esperar a que el driver termine
            END IF;
        END IF;
    END PROCESS p_refresh_logic;

END ARCHITECTURE rtl;