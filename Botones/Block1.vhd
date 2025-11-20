-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
-- CREATED		"Mon Nov 17 18:08:45 2025"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY Block1 IS 
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
END Block1;

ARCHITECTURE bdf_type OF Block1 IS 

COMPONENT tateti
	PORT(reset : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 x : IN STD_LOGIC;
		 T : IN STD_LOGIC;
		 z : OUT STD_LOGIC;
		 cont : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT binary_counter
GENERIC (MAX_COUNT : INTEGER;
			MIN_COUNT : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 T : OUT STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(0 TO 2001)
	);
END COMPONENT;

COMPONENT matrizbotones
	PORT(c3 : IN STD_LOGIC;
		 c2 : IN STD_LOGIC;
		 c1 : IN STD_LOGIC;
		 c0 : IN STD_LOGIC;
		 fila : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 posicion : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT botonera
	PORT(reset : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 x0 : IN STD_LOGIC;
		 x1 : IN STD_LOGIC;
		 x2 : IN STD_LOGIC;
		 x3 : IN STD_LOGIC;
		 fila : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 Z : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pllclk
	PORT(inclk0 : IN STD_LOGIC;
		 areset : IN STD_LOGIC;
		 c0 : OUT STD_LOGIC;
		 locked : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_27 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_28 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_29 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_30 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_31 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_32 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_25 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC;


BEGIN 
c0 <= SYNTHESIZED_WIRE_32;
c1 <= SYNTHESIZED_WIRE_31;
c2 <= SYNTHESIZED_WIRE_30;
c3 <= SYNTHESIZED_WIRE_29;
ORoOR <= SYNTHESIZED_WIRE_4;
salida <= SYNTHESIZED_WIRE_13;
SYNTHESIZED_WIRE_19 <= '0';



b2v_inst : tateti
PORT MAP(reset => SYNTHESIZED_WIRE_27,
		 clock => clk,
		 x => x3,
		 T => SYNTHESIZED_WIRE_28,
		 z => SYNTHESIZED_WIRE_29,
		 cont => SYNTHESIZED_WIRE_23);


b2v_inst1 : binary_counter
GENERIC MAP(MAX_COUNT => 2001,
			MIN_COUNT => 0
			)
PORT MAP(clk => SYNTHESIZED_WIRE_2,
		 reset => SYNTHESIZED_WIRE_27,
		 enable => SYNTHESIZED_WIRE_4,
		 T => SYNTHESIZED_WIRE_28);


b2v_inst10 : tateti
PORT MAP(reset => SYNTHESIZED_WIRE_27,
		 clock => clk,
		 x => x1,
		 T => SYNTHESIZED_WIRE_28,
		 z => SYNTHESIZED_WIRE_31,
		 cont => SYNTHESIZED_WIRE_24);


b2v_inst11 : tateti
PORT MAP(reset => SYNTHESIZED_WIRE_27,
		 clock => clk,
		 x => x0,
		 T => SYNTHESIZED_WIRE_28,
		 z => SYNTHESIZED_WIRE_32,
		 cont => SYNTHESIZED_WIRE_25);



b2v_inst2 : matrizbotones
PORT MAP(c3 => SYNTHESIZED_WIRE_29,
		 c2 => SYNTHESIZED_WIRE_30,
		 c1 => SYNTHESIZED_WIRE_31,
		 c0 => SYNTHESIZED_WIRE_32,
		 fila => SYNTHESIZED_WIRE_13,
		 posicion => posicionnes);


b2v_inst6 : botonera
PORT MAP(reset => SYNTHESIZED_WIRE_27,
		 clock => clk,
		 x0 => SYNTHESIZED_WIRE_32,
		 x1 => SYNTHESIZED_WIRE_31,
		 x2 => SYNTHESIZED_WIRE_30,
		 x3 => SYNTHESIZED_WIRE_29,
		 fila => SYNTHESIZED_WIRE_13,
		 Z => Z);


b2v_inst7 : pllclk
PORT MAP(inclk0 => clk,
		 areset => SYNTHESIZED_WIRE_19,
		 c0 => SYNTHESIZED_WIRE_2,
		 locked => SYNTHESIZED_WIRE_20);


SYNTHESIZED_WIRE_27 <= NOT(SYNTHESIZED_WIRE_20);



b2v_inst9 : tateti
PORT MAP(reset => SYNTHESIZED_WIRE_27,
		 clock => clk,
		 x => x2,
		 T => SYNTHESIZED_WIRE_28,
		 z => SYNTHESIZED_WIRE_30,
		 cont => SYNTHESIZED_WIRE_26);


SYNTHESIZED_WIRE_4 <= SYNTHESIZED_WIRE_23 OR SYNTHESIZED_WIRE_24 OR SYNTHESIZED_WIRE_25 OR SYNTHESIZED_WIRE_26;


END bdf_type;