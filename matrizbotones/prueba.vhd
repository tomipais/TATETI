LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity prueba is
	port(
		clk : in std_logic;
		sw1 : in std_logic;
		sw2 : in std_logic;
		sw3 : in std_logic;
		sw4 : in std_logic;
		led : out std_logic_vector(3 downto 0)
	);
end prueba;

architecture p1 of prueba is
component Block1 is
	PORT
	(
		x0 :  IN  STD_LOGIC;
		x1 :  IN  STD_LOGIC;
		x2 :  IN  STD_LOGIC;
		x3 :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		c0 :  OUT  STD_LOGIC;
		c1 :  OUT  STD_LOGIC;
		c2 :  OUT  STD_LOGIC;
		c3 :  OUT  STD_LOGIC;
		ORoOR :  OUT  STD_LOGIC;
		posicionnes :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		salida :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		Z :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END component;

begin
uut: Block1
 port map(x0 => sw1,
		x1 => sw2,	
		x2 => sw3,
		x3 => sw4,
		clk => clk,  
		c0 => open,  
		c1 => open,  
		c2 => open, 
		c3 => open, 
		ORoOR => open, 
		posicionnes => led, 
		salida => open, 
		Z => open
		);
end p1;