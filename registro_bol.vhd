LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;
-------------------------------------
ENTITY registro_bol IS
	GENERIC	(	MAX_WIDTH		:	INTEGER	:=	10);
	PORT (	clk	:	IN 	STD_LOGIC; 
				rst 	: 	IN 	STD_LOGIC;
				ena 	:	IN 	STD_LOGIC;
				pa, pb:	IN		STD_LOGIC;
				d_x 	:	IN 	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				d_y 	:	IN 	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				q_x	:	OUT	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				q_y 	:	OUT	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0));
END ENTITY;
-------------------------------------
ARCHITECTURE rtl of registro_bol is
	SIGNAL reset : STD_LOGIC;
BEGIN

	reset <= rst OR pa OR pb;
	
	dff_y: PROCESS(clk, rst, reset, d_y, ena)
	BEGIN
		IF(reset = '1') THEN --hacer or sinclr
			q_y <= "0011110000"; --240
		ELSIF (rising_edge(clk)) THEN
			IF(reset = '1') THEN
				q_y <= "0011110000"; --240
			ELSIF  (ena = '1') THEN
				q_y <= d_y;
			END IF;
		END IF;
	END PROCESS;

	dff_x: PROCESS(clk, rst, reset, d_x, ena)
	BEGIN
		IF(reset = '1') THEN
			q_x <= "0101000000"; --320
		ELSIF (rising_edge(clk)) THEN
			IF(reset = '1') THEN
				q_x <= "0101000000"; --240
			ELSIF  (ena = '1') THEN
				q_x <= d_x;
			END IF;
		END IF;
	END PROCESS;
	
END ARCHITECTURE;