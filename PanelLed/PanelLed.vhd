LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY PanelLed IS
    GENERIC (
        -- Frecuencia del reloj del sistema (ej: 50MHz)
        G_CLK_FREQ      : INTEGER := 50_000_000;
        -- Frecuencia de parpadeo para animaciones (ej: 2 Hz)
        G_BLINK_FREQ_HZ : INTEGER := 2
    );
    PORT (
        -- === Control ===
        clk   : IN STD_LOGIC;
        reset : IN STD_LOGIC; -- Reset global

        -- === Entradas de Lógica de Juego (Externas) ===
        
        -- Pulso que indica el inicio de una nueva ronda (limpia el tablero)
        new_game_start_in : IN STD_LOGIC; 
        
        -- La jugada realizada
        -- (Asumo 0-8 para el tablero, 4 bits como pediste)
        move_pos_in  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        -- Pulso que indica que 'move_pos_in' es una jugada válida
        move_valid_in : IN STD_LOGIC; 

        -- Puntajes (provistos por la lógica externa)
        score_p1_in : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        score_p2_in : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

        -- Estado de la partida (provisto por la lógica externa)
        -- "00" = En curso
        -- "01" = Gana Jugador 1
        -- "10" = Gana Jugador 2
        -- "11" = Empate
        game_state_in : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

        -- Línea ganadora (provista por la lógica externa)
        win_line_in : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

        -- === Salida ===
        led_data_out : OUT STD_LOGIC_VECTOR(383 DOWNTO 0)
    );
END ENTITY PanelLed;

ARCHITECTURE rtl OF PanelLed IS

    -- --- Definición de Colores (24 bits GRB) ---
    -- !!!!!!!!!!!!!! ESTA ES LA LÍNEA CORREGIDA (sin paréntesis) !!!!!!!!!!!!!!
    SUBTYPE T_LED_COLOR IS STD_LOGIC_VECTOR(23 DOWNTO 0);
    
    CONSTANT C_COLOR_OFF    : T_LED_COLOR := x"000000";
    CONSTANT C_COLOR_GREEN  : T_LED_COLOR := x"FF0000"; -- Jugador 1
    CONSTANT C_COLOR_BLUE   : T_LED_COLOR := x"0000FF"; -- Jugador 2
    CONSTANT C_COLOR_WHITE  : T_LED_COLOR := x"FFFFFF"; -- Animación
    CONSTANT C_COLOR_YELLOW : T_LED_COLOR := x"FFFF00"; -- Animación

    -- Constante para el contador de parpadeo
    CONSTANT C_BLINK_PERIOD : INTEGER := (G_CLK_FREQ / G_BLINK_FREQ_HZ) / 2;

    -- --- Framebuffer Interno (16 LEDs) ---
    TYPE T_LED_ARRAY IS ARRAY (0 TO 15) OF T_LED_COLOR;
    SIGNAL s_led_framebuffer : T_LED_ARRAY := (OTHERS => C_COLOR_OFF);

    -- --- Estado Interno del Módulo ---
    -- '0' = Turno P1 (Verde), '1' = Turno P2 (Azul)
    SIGNAL s_current_turn : STD_LOGIC := '0';

    -- Estado interno de las 9 casillas del tablero
    -- "00" = Vacío, "01" = P1, "10" = P2
    TYPE T_BOARD_STATE IS ARRAY (0 TO 8) OF STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL s_board_state : T_BOARD_STATE := (OTHERS => "00");

    -- --- Señales para Animación ---
    SIGNAL s_blink_counter : INTEGER RANGE 0 TO C_BLINK_PERIOD;
    SIGNAL s_blink_toggle  : STD_LOGIC := '0';

BEGIN

    -- 1. Proceso de Almacenamiento de Estado (Clocked)
    -- Actualiza el estado del tablero interno y el turno
    p_game_state_update : PROCESS (clk, reset)
        VARIABLE v_move_pos_int : INTEGER;
    BEGIN
        IF (reset = '1') THEN
            s_board_state  <= (OTHERS => "00");
            s_current_turn <= '0';
        ELSIF (rising_edge(clk)) THEN
            
            -- Si 'new_game_start_in' está activo, se limpia el tablero
            IF (new_game_start_in = '1') THEN
                s_board_state  <= (OTHERS => "00");
                s_current_turn <= '0'; -- P1 siempre empieza
            
            -- Si hay una jugada válida, se actualiza el tablero interno
            ELSIF (move_valid_in = '1') THEN
                v_move_pos_int := to_integer(unsigned(move_pos_in));
                
                -- Solo actualizar si la posición está en el rango 0-8
                IF (v_move_pos_int <= 8) THEN
                    IF (s_current_turn = '0') THEN
                        s_board_state(v_move_pos_int) <= "01"; -- P1 (Verde)
                        s_current_turn <= '1'; -- Cambia al turno P2
                    ELSE
                        s_board_state(v_move_pos_int) <= "10"; -- P2 (Azul)
                        s_current_turn <= '0'; -- Cambia al turno P1
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS p_game_state_update;

    -- 2. Proceso de Parpadeo (Clocked)
    -- Genera una señal 's_blink_toggle' que cambia a G_BLINK_FREQ_HZ
    p_blinker : PROCESS (clk, reset)
    BEGIN
        IF (reset = '1') THEN
            s_blink_counter <= 0;
            s_blink_toggle  <= '0';
        ELSIF (rising_edge(clk)) THEN
            IF (s_blink_counter = C_BLINK_PERIOD - 1) THEN
                s_blink_counter <= 0;
                s_blink_toggle  <= NOT s_blink_toggle;
            ELSE
                s_blink_counter <= s_blink_counter + 1;
            END IF;
        END IF;
    END PROCESS p_blinker;

    -- 3. Lógica de Display (Combinacional)
    -- Traduce el estado interno (s_board_state, s_current_turn)
    -- y las entradas (score_*, game_state_in) a los 16 LEDs.
    p_led_logic : PROCESS (s_board_state, s_current_turn, score_p1_in, score_p2_in, game_state_in, win_line_in, s_blink_toggle)
        VARIABLE v_led_frame : T_LED_ARRAY;
        VARIABLE v_anim_color : T_LED_COLOR;
    BEGIN
        -- Por defecto, todos los LEDs apagados
        v_led_frame := (OTHERS => C_COLOR_OFF);

        -- --- A. Lógica Base (Se dibuja si no es Empate) ---
        IF (game_state_in /= "11") THEN
            -- A.1. Dibujar el Tablero (LEDs 0-8) desde el estado interno
            FOR i IN 0 TO 8 LOOP
                CASE s_board_state(i) IS
                    WHEN "01" => -- Jugador 1
                        v_led_frame(i) := C_COLOR_GREEN;
                    WHEN "10" => -- Jugador 2
                        v_led_frame(i) := C_COLOR_BLUE;
                    WHEN OTHERS => -- Vacío
                        v_led_frame(i) := C_COLOR_OFF;
                END CASE;
            END LOOP;

            -- A.2. Dibujar Marcador (LEDs 9-12)
            IF score_p1_in(0) = '1' THEN v_led_frame(9)  := C_COLOR_GREEN; END IF;
            IF score_p1_in(1) = '1' THEN v_led_frame(10) := C_COLOR_GREEN; END IF;
            IF score_p2_in(0) = '1' THEN v_led_frame(11) := C_COLOR_BLUE;  END IF;
            IF score_p2_in(1) = '1' THEN v_led_frame(12) := C_COLOR_BLUE;  END IF;
            -- LEDs 13, 14 libres
        END IF;

        -- --- B. Lógica de Estado de Juego (Sobrescribe lo anterior) ---
        CASE game_state_in IS
            -- === EN CURSO ===
            WHEN "00" =>
                -- Indicador de Turno (LED 15) basado en el estado interno
                IF s_current_turn = '0' THEN
                    v_led_frame(15) := C_COLOR_GREEN; -- Turno P1
                ELSE
                    v_led_frame(15) := C_COLOR_BLUE;  -- Turno P2
                END IF;

            -- === GANA JUGADOR 1 o 2 ===
            WHEN "01" | "10" =>
                IF s_blink_toggle = '1' THEN
                    v_anim_color := C_COLOR_YELLOW;
                ELSE
                    v_anim_color := C_COLOR_WHITE;
                END IF;

                -- Sobrescribir los 3 LEDs de la línea ganadora
                CASE win_line_in IS
                    WHEN "000" => -- Fila 0
                        v_led_frame(0) := v_anim_color; v_led_frame(1) := v_anim_color; v_led_frame(2) := v_anim_color;
                    WHEN "001" => -- Fila 1
                        v_led_frame(3) := v_anim_color; v_led_frame(4) := v_anim_color; v_led_frame(5) := v_anim_color;
                    WHEN "010" => -- Fila 2
                        v_led_frame(6) := v_anim_color; v_led_frame(7) := v_anim_color; v_led_frame(8) := v_anim_color;
                    WHEN "011" => -- Col 0
                        v_led_frame(0) := v_anim_color; v_led_frame(3) := v_anim_color; v_led_frame(6) := v_anim_color;
                    WHEN "100" => -- Col 1
                        v_led_frame(1) := v_anim_color; v_led_frame(4) := v_anim_color; v_led_frame(7) := v_anim_color;
                    WHEN "101" => -- Col 2
                        v_led_frame(2) := v_anim_color; v_led_frame(5) := v_anim_color; v_led_frame(8) := v_anim_color;
                    WHEN "110" => -- Diag Principal
                        v_led_frame(0) := v_anim_color; v_led_frame(4) := v_anim_color; v_led_frame(8) := v_anim_color;
                    WHEN "111" => -- Diag Secundaria
                        v_led_frame(2) := v_anim_color; v_led_frame(4) := v_anim_color; v_led_frame(6) := v_anim_color;
                    WHEN OTHERS => NULL;
                END CASE;

            -- === EMPATE ===
            WHEN "11" =>
                IF s_blink_toggle = '1' THEN
                    v_anim_color := C_COLOR_WHITE;
                ELSE
                    v_anim_color := C_COLOR_OFF;
                END IF;
                -- Aplicar a TODOS los 16 LEDs
                FOR i IN 0 TO 15 LOOP
                    v_led_frame(i) := v_anim_color;
                END LOOP;

            WHEN OTHERS => NULL;
        END CASE;

        -- Asignar el estado calculado al "framebuffer" de salida
        s_led_framebuffer <= v_led_frame;

    END PROCESS p_led_logic;

    -- 4. Aplanador de Salida (Concurrent)
    -- Concatena el array 2D s_led_framebuffer en el vector 1D led_data_out
    gen_flatten : FOR i IN 0 TO 15 GENERATE
        led_data_out((i * 24) + 23 DOWNTO (i * 24)) <= s_led_framebuffer(i);
    END GENERATE gen_flatten;

END ARCHITECTURE rtl;