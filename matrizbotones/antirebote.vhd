library ieee;
 use ieee.std_logic_1164.all;

 entity antirebote is 
 port (clk,rst:in std_logic;
		 sw : in std_logic;
		 valido: out std_logic);
end entity;

architecture uno of antirebote is 
			type state_type is (s0,s1,s2,s3);
			signal state : state_type;
			
			signal cnt : integer range 0 to 8;
			
begin
	process(clk,rst)
	begin
		if (rst='0') then
			state <=s0;
			cnt <= 0;
			elsif (rising_edge(clk)) then
				case state is 
					when s0 =>
						if sw = '1' then
							state <= s0;
						else 
							state <= s1;
						end if;
					when s1 =>
						if cnt=8 then
							cnt<=0;
							state <= s2;
						else
							cnt <= cnt + 1;
						end if;
					when s2 => 
						if sw ='0' then
							state <= s3;
						else
							state <= s0;
						end if;
					when s3 =>
						if sw='0' then
							state <= s3;
						else
							state <= s0;
						end if;
					end case;
				end if;
			end process;
			
		process (state)
		begin
			case state is 
				when s0=> valido <= '0';
				when s1=> valido <= '0';
				when s2=> valido <= '0';
				when s3=> valido <= '1';
			end case;
		end process;
end uno;