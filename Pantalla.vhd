library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Pantalla IS
PORT (	con_h 	: IN  STD_LOGIC_VECTOR (9 downto 0);
			con_v 	: IN  STD_LOGIC_VECTOR (9 downto 0);
			visible 	: OUT STD_LOGIC);
END Pantalla;

ARCHITECTURE Behavioral OF Pantalla IS
BEGIN

PROCESS (con_h, con_v)
BEGIN
	IF ((con_h >= "1010000000") AND (con_h <= "1100011111")) OR ((con_v >= "0111100000") AND (con_v <= "1000001100")) THEN
		visible <= '0';
	ELSE
		visible <= '1';
	END IF;
END PROCESS;
END Behavioral;