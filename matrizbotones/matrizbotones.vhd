library ieee;
use ieee. std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity matrizbotones is
	port(
		fila : in std_logic_vector(3 downto 0);
		c3 : in std_logic;
		c2 : in std_logic;
		c1 : in std_logic;
		c0 : in std_logic;
		posicion : out unsigned(3 downto 0) 
	);
end matrizbotones;

--architecture recorrermatriz of matrizbotones is
--	signal x: std_logic_vector(7 downto 0)	;
--		begin
--			x<=fila&columna;
--	recorre: process (fila, columna, x) is 
----		begin
----			variable i:integer;
----			variable j: integer;
----		begin	
----		
----	
----		for j in 0 to 3 loop
----			for i in 0 to 3 loop 
----					fila(i)<= 1;
----					wait for 10ms;-- esto no sirve para implementacion
----				end loop;
----			if columna(j)=1 then to_stdlogicvector(integer(i&j));
----		end if;
----		end loop;
----			
----		x(1) <= j;
----		x(0) <= i;
----			
--			case x is
--				
--				when "00010001" => posicion<="1111";
--				when "00010010" => posicion<="1110";
--				when "00010100" => posicion<="1101";
--				when "00011000" => posicion<="1100";
--				when "00100001" => posicion<="1011";
--				when "00100010" => posicion<="1010";
--				when "00100100" => posicion<="1001";
--				when "00101000" => posicion<="1000";
--				when "01000001" => posicion<="0111";
--				when "01000010" => posicion<="0110";
--				when "01000100" => posicion<="0101";
--				when "01001000" => posicion<="0100";
--				when "10000001" => posicion<="0011";
--				when "10000010" => posicion<="0010";
--				when "10000100" => posicion<="0001";
--				when "10001000" => posicion<="0000";
--				when others => posicion<="1111";
--
----				when "00" => posicion<="1111";
----				when "01" => posicion<="1110";
----				when "02" => posicion<="1101";
----				when "03" => posicion<="1100";
----				when "10" => posicion<="1011";
----				when "11" => posicion<="1010";
----				when "12" => posicion<="1001";
----				when "13" => posicion<="1000";
----				when "20" => posicion<="0111";
----				when "21" => posicion<="0110";
----				when "22" => posicion<="0101";
----				when "23" => posicion<="0100";
----				when "30" => posicion<="0011";
----				when "31" => posicion<="0010";
----				when "32" => posicion<="0001";
----				when "33" => posicion<="0000";
----				when others => posicion<="1111";
----				
--			end case;
--		
--			
--	end process recorre;
	ARCHITECTURE recorrermatriz OF matrizbotones IS
	SIGNAL x: STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal columna : std_logic_vector(3 downto 0);
BEGIN
    -- Asignación concurrente (siempre correcta)
	x <= fila & columna;

	-- *** CORRECCIÓN DE SINTAXIS: Se añade BEGIN al PROCESS ***
	recorre: PROCESS (fila, columna, x) IS
    -- Nota: No hay declaraciones de variables aquí, así que va directo el BEGIN.
    BEGIN
			
        -- NOTA IMPORTANTE: Todo este PROCESS solo decodifica (es combinacional)
        -- No realiza el escaneo de filas (eso requiere CLOCK y lógica secuencial)

        CASE x IS
            
            WHEN "00010001" => posicion<="1111";
            WHEN "00010010" => posicion<="1110";
            WHEN "00010100" => posicion<="1101";
            WHEN "00011000" => posicion<="1100";
            WHEN "00100001" => posicion<="1011";
            WHEN "00100010" => posicion<="1010";
            WHEN "00100100" => posicion<="1001";
            WHEN "00101000" => posicion<="1000";
            WHEN "01000001" => posicion<="0111";
            WHEN "01000010" => posicion<="0110";
            WHEN "01000100" => posicion<="0101";
            WHEN "01001000" => posicion<="0100";
            WHEN "10000001" => posicion<="0011";
            WHEN "10000010" => posicion<="0010";
            WHEN "10000100" => posicion<="0001";
            WHEN "10001000" => posicion<="0000";
            WHEN OTHERS => posicion<="1111";

		END CASE;
			
	END PROCESS recorre;
columna(3)<= c3;
columna(2)<=c2;
columna(1)<=c1;
columna(0)<=c0;

	
	
end architecture recorrermatriz;
	