LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;
-------------------------------------
ENTITY registro_raq IS
	GENERIC	(	MAX_WIDTH		:	INTEGER	:=	10);
	PORT (	clk	:	IN 	STD_LOGIC; 
				rst 	: 	IN 	STD_LOGIC;
				ena 	:	IN 	STD_LOGIC;
				d 		:	IN 	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				q 		:	OUT	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0));
END ENTITY;
-------------------------------------
ARCHITECTURE rtl of registro_raq is
BEGIN

	dff: PROCESS(clk, rst, d, ena)
	BEGIN
		IF(rst = '1') THEN
			q <= "0100000001"; --257
		ELSIF (rising_edge(clk)) THEN
			IF  (ena = '1') THEN
				q <= d;
			END IF;
		END IF;
	END PROCESS;	
	
END ARCHITECTURE;