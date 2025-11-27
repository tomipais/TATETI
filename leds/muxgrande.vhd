library ieee;
use ieee.std_logic_1164.all;

entity muxgrande is
    port(
        led0: in  std_logic_vector(23 downto 0);
		  led1: in  std_logic_vector(23 downto 0);
		  led2: in  std_logic_vector(23 downto 0);
		  led3: in  std_logic_vector(23 downto 0);
		  led4: in  std_logic_vector(23 downto 0);
		  led5: in  std_logic_vector(23 downto 0);
		  led6: in  std_logic_vector(23 downto 0);
		  led7: in  std_logic_vector(23 downto 0);
		  led8: in  std_logic_vector(23 downto 0);
		  led9: in  std_logic_vector(23 downto 0);
		  led10: in  std_logic_vector(23 downto 0);
		  led11: in  std_logic_vector(23 downto 0);
		  led12:in  std_logic_vector(23 downto 0);
		  led13: in  std_logic_vector(23 downto 0);
		  led14: in  std_logic_vector(23 downto 0);
		  led15: in  std_logic_vector(23 downto 0);
        sel : in  std_logic_vector(3 downto 0);
        y   : out std_logic_vector(23 downto 0)
    );
end muxgrande;

architecture rtl of muxgrande is
begin
    process(sel, led0,led1,led2,led3,led4,led5,led6,led7,led8,led9,led10,led11,led12,led13,led14,led15)
    begin
        case sel is
            when "0000" =>
                y <= led0;
            when "0001" =>
                y <= led1;
				when "0010" =>
                y <= led2;
				when "0011" =>
                y <= led3;
				when "0100" =>
                y <= led4;
				when "0101" =>
                y <= led5;
				when "0110" =>
                y <= led6;
				when "0111" =>
                y <= led7;
				when "1000" =>
                y <= led8;
				when "1001" =>
                y <= led9;
				when "1010" =>
                y <= led10;
				when "1011" =>
                y <= led11;
				when "1100" =>
                y <= led12;
				when "1101" =>
                y <= led13;
				when "1110" =>
                y <= led14;
				when "1111" =>
                y <= led15;
					
            when others =>
                y <= led0;
        end case;
    end process;
end rtl;
