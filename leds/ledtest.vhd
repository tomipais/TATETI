library ieee;
use ieee.std_logic_1164.all;

entity ledtest is
    port(
        led0_out  : out std_logic_vector(23 downto 0);
        led1_out  : out std_logic_vector(23 downto 0);
        led2_out  : out std_logic_vector(23 downto 0);
        led3_out  : out std_logic_vector(23 downto 0);
        led4_out  : out std_logic_vector(23 downto 0);
        led5_out  : out std_logic_vector(23 downto 0);
        led6_out  : out std_logic_vector(23 downto 0);
        led7_out  : out std_logic_vector(23 downto 0);
        led8_out  : out std_logic_vector(23 downto 0);
        led9_out  : out std_logic_vector(23 downto 0);
        led10_out : out std_logic_vector(23 downto 0);
        led11_out : out std_logic_vector(23 downto 0);
        led12_out : out std_logic_vector(23 downto 0);
        led13_out : out std_logic_vector(23 downto 0);
        led14_out : out std_logic_vector(23 downto 0);
        led15_out : out std_logic_vector(23 downto 0)
    );
end entity;

architecture rtl of ledtest is

    -- Colores configurables (en formato RGB)
    constant led0  : std_logic_vector(23 downto 0) := "111100001111111100000000"; -- Rojo
    constant led1  : std_logic_vector(23 downto 0) := "000000001111111100000000"; -- Verde
    constant led2  : std_logic_vector(23 downto 0) := "000000001111111100000000"; -- Azul
    constant led3  : std_logic_vector(23 downto 0) := "000000001111111100000000"; -- Blanco
    constant led4  : std_logic_vector(23 downto 0) := "000000001111111110101010"; -- Amarillo
    constant led5  : std_logic_vector(23 downto 0) := "000000001001111100000000"; -- Magenta
    constant led6  : std_logic_vector(23 downto 0) := "000000001111111100000000"; -- Cian
    constant led7  : std_logic_vector(23 downto 0) := "000000001111111100000000"; -- Negro (apagado)
    constant led8  : std_logic_vector(23 downto 0) := "100101111111101100000000";
    constant led9  : std_logic_vector(23 downto 0) := "000000001111111100000000";
    constant led10 : std_logic_vector(23 downto 0) := "000000001111111100000000";
    constant led11 : std_logic_vector(23 downto 0) := "000000001111111100000000";
    constant led12 : std_logic_vector(23 downto 0) := "000000001111111100000000";
    constant led13 : std_logic_vector(23 downto 0) := "000000001111111100000000";
    constant led14 : std_logic_vector(23 downto 0) := "000000001111101100000000";
    constant led15 : std_logic_vector(23 downto 0) := "000000001111111100000000";

begin

    -- Asignación paralela a las salidas
    led0_out  <= led0;
    led1_out  <= led1;
    led2_out  <= led2;
    led3_out  <= led3;
    led4_out  <= led4;
    led5_out  <= led5;
    led6_out  <= led6;
    led7_out  <= led7;
    led8_out  <= led8;
    led9_out  <= led9;
    led10_out <= led10;
    led11_out <= led11;
    led12_out <= led12;
    led13_out <= led13;
    led14_out <= led14;
    led15_out <= led15;

end rtl;
