library ieee;
use ieee. std_logic_1164.all;

entity matrizbotones is
	port(
		fila : out std_logic_vector(3 downto 0);
		columna : in std_logic_vector(3 downto 0);
		posicion : out unsigned(3 downto 0) 
	);
end matrizbotones;

architecture recorrermatriz of matrizbotones is
	signal x: std_logic_vector(7 downto 0)	;
	begin	
		x <= fila&columna;
		recorre: process (fila, columna, x) is 
		
			variable i:integer;
			variable j: integer;
	begin
		for j in 0 to 3 loop
			for i in 0 to 3 loop 
					fila(i):=1;
					wait for 10ms;-- esto no sirve para implementacion
				end loop;
			if columna(j):='1' then to_stdlogicvector(integer(i&j));
		end loop;
			
			
			
			case x is
				
				when "00010001" => posicion<="1111";
				when "00010010" => posicion<="1110";
				when "00010100" => posicion<="1101";
				when "00011000" => posicion<="1100";
				when "00100001" => posicion<="1011";
				when "00100010" => posicion<="1010";
				when "00100100" => posicion<="1001";
				when "00101000" => posicion<="1000";
				when "01000001" => posicion<="0111";
				when "01000010" => posicion<="0110";
				when "01000100" => posicion<="0101";
				when "01001000" => posicion<="0100";
				when "10000001" => posicion<="0011";
				when "10000010" => posicion<="0010";
				when "10000100" => posicion<="0001";
				when "10001000" => posicion<="0000";
				when others => posicion<="1111";
				
			end case;
		
			
		end process recorre;
	
	
	
end architecture recorrermatriz;
	