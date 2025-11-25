library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
    port(
        c0  : in  std_logic;
        c1  : in  std_logic;
        sel : in  std_logic;
        y   : out std_logic
    );
end mux2;

architecture rtl of mux2 is
begin
    process(c0, c1, sel)
    begin
        case sel is
            when '0' =>
                y <= c0;
            when '1' =>
                y <= c1;
            when others =>
                y <= 'X';
        end case;
    end process;
end rtl;
