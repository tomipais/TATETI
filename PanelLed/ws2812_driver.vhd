LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ws2812_driver IS
    GENERIC (
        G_CLK_FREQ  : INTEGER := 50_000_000; -- Reloj de 50MHz
        G_LED_COUNT : INTEGER := 16           -- 16 LEDs en tu panel
    );
    PORT (
        clk   : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        -- Interfaz con tu lógica PanelLed
        parallel_data_in : IN  STD_LOGIC_VECTOR((G_LED_COUNT * 24) - 1 DOWNTO 0);
        start_transfer   : IN  STD_LOGIC; -- Pulso para iniciar la transferencia
        busy_out         : OUT STD_LOGIC; -- '1' mientras envía datos

        -- Salida física
        led_serial_out : OUT STD_LOGIC
    );
END ENTITY ws2812_driver;

ARCHITECTURE rtl OF ws2812_driver IS

    -- Tiempos para WS2812B (protocolo de 800kHz)
    -- Período del reloj de 50MHz = 20 ns
    CONSTANT C_T0H_CYCLES : INTEGER := (400 / 20);   -- 400ns  = 20 ciclos
    CONSTANT C_T0L_CYCLES : INTEGER := (850 / 20);   -- 850ns  = 43 ciclos (redondeado)
    CONSTANT C_T1H_CYCLES : INTEGER := (800 / 20);   -- 800ns  = 40 ciclos
    CONSTANT C_T1L_CYCLES : INTEGER := (450 / 20);   -- 450ns  = 23 ciclos (redondeado)
    CONSTANT C_RESET_CYCLES : INTEGER := (300000 / 20); -- 300us = 15000 ciclos (latch)

    -- Total de bits a enviar
    CONSTANT C_TOTAL_BITS : INTEGER := (G_LED_COUNT * 24);

    -- Estados de la máquina
    TYPE T_STATE IS (S_IDLE, S_SHIFT, S_T_HIGH, S_T0_LOW, S_T1_LOW, S_LATCH);
    SIGNAL s_state : T_STATE := S_IDLE;

    -- Registros internos
    SIGNAL s_data_reg    : STD_LOGIC_VECTOR(C_TOTAL_BITS - 1 DOWNTO 0);
    SIGNAL s_bit_counter : INTEGER RANGE 0 TO C_TOTAL_BITS;
    SIGNAL s_timer       : INTEGER RANGE 0 TO C_RESET_CYCLES;
    SIGNAL s_current_bit : STD_LOGIC;

BEGIN

    p_ws2812_fsm : PROCESS (clk, reset)
    BEGIN
        IF (reset = '1') THEN
            s_state          <= S_IDLE;
            s_timer          <= 0;
            s_bit_counter    <= 0;
            s_data_reg       <= (OTHERS => '0');
            s_current_bit    <= '0';
            led_serial_out   <= '0';
            busy_out         <= '0';
            
        ELSIF (rising_edge(clk)) THEN
            CASE s_state IS
                
                WHEN S_IDLE =>
                    led_serial_out <= '0';
                    busy_out       <= '0';
                    s_timer        <= 0;
                    
                    IF (start_transfer = '1') THEN
                        s_data_reg    <= parallel_data_in; -- Carga los 384 bits
                        s_bit_counter <= C_TOTAL_BITS - 1; -- Apunta al bit 383
                        busy_out      <= '1';
                        s_state       <= S_SHIFT;
                    END IF;
                    
                WHEN S_SHIFT =>
                    s_current_bit <= s_data_reg(s_bit_counter);
                    s_timer       <= 0;
                    s_state       <= S_T_HIGH;

                WHEN S_T_HIGH =>
                    led_serial_out <= '1';
                    s_timer <= s_timer + 1;
                    
                    IF (s_current_bit = '0') THEN
                        IF (s_timer = C_T0H_CYCLES - 1) THEN
                            s_timer <= 0;
                            s_state <= S_T0_LOW;
                        END IF;
                    ELSE -- Bit es '1'
                        IF (s_timer = C_T1H_CYCLES - 1) THEN
                            s_timer <= 0;
                            s_state <= S_T1_LOW;
                        END IF;
                    END IF;

                WHEN S_T0_LOW =>
                    led_serial_out <= '0';
                    s_timer <= s_timer + 1;
                    
                    IF (s_timer = C_T0L_CYCLES - 1) THEN
                        IF (s_bit_counter = 0) THEN
                            s_state <= S_LATCH; -- Terminó
                        ELSE
                            s_bit_counter <= s_bit_counter - 1;
                            s_state <= S_SHIFT; -- Siguiente bit
                        END IF;
                    END IF;
                    
                WHEN S_T1_LOW =>
                    led_serial_out <= '0';
                    s_timer <= s_timer + 1;
                    
                    IF (s_timer = C_T1L_CYCLES - 1) THEN
                         IF (s_bit_counter = 0) THEN
                            s_state <= S_LATCH; -- Terminó
                        ELSE
                            s_bit_counter <= s_bit_counter - 1;
                            s_state <= S_SHIFT; -- Siguiente bit
                        END IF;
                    END IF;

                WHEN S_LATCH =>
                    led_serial_out <= '0';
                    s_timer <= s_timer + 1;
                    
                    IF (s_timer = C_RESET_CYCLES - 1) THEN
                        s_timer <= 0;
                        s_state <= S_IDLE; -- Listo para otra transferencia
                    END IF;

            END CASE;
        END IF;
    END PROCESS p_ws2812_fsm;

END ARCHITECTURE rtl;