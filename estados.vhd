----------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
----------------------------------------------------------------
ENTITY  estados IS
	PORT	(	clk				:	IN		STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				fin, start		: 	IN 	STD_LOGIC;
				ena				:	OUT	STD_LOGIC;
				hab				:	OUT   STD_LOGIC;
				gameover			:	OUT   STD_LOGIC);
END ENTITY estados;
----------------------------------------------------------------
ARCHITECTURE fsm OF estados IS
	TYPE state IS (espera,juego);
	SIGNAL prv_state, next_state	:	state;
BEGIN
	sequential: PROCESS(rst, clk)
	BEGIN
		IF (rst = '1') THEN
			prv_state	<=	espera;
		ELSIF (rising_edge(clk)) THEN
			prv_state	<=	next_state;
		END IF;
	END PROCESS sequential;

	combinational: PROCESS(prv_state, fin, start)
	BEGIN
		CASE prv_state IS
			
	WHEN juego	=>
				IF (fin='1') THEN
					gameover<='1';
					ena<='0';
					hab<='1';
					next_state<=espera;
				ELSE
					gameover<='0';
					ena<='1';
					hab<='0';
					next_state<=juego;
				END IF;					
				 
	WHEN espera	=>
				IF (start<='1') THEN
					gameover<='0';
					ena<='1';
					hab<='0';
					next_state<=juego;
				ELSE
					gameover<='1';
					ena<='0';
					hab<='1';
					next_state<=espera;
				END IF;	
				
		END CASE;
	END PROCESS combinational;
	
END ARCHITECTURE fsm;