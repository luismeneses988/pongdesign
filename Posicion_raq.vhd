----------------------------------------------------------------
library IEEE;
 use IEEE.STD_LOGIC_1164.ALL; 
 use IEEE.STD_LOGIC_ARITH.ALL; 
 use IEEE.NUMERIC_STD.ALL;
 use IEEE.STD_LOGIC_UNSIGNED.ALL; 
----------------------------------------------------------------
ENTITY  Posicion_raq IS
	PORT	(	Actual 				:	IN 	STD_LOGIC;
				Clk					:	IN		STD_LOGIC;
				Pos_pre				:	IN		STD_LOGIC_VECTOR ( 9 DOWNTO 0);				
				E_Arriba				:	IN    STD_LOGIC;
				E_Abajo				:	IN		STD_LOGIC;
				Pos_actual			:	out	STD_LOGIC_VECTOR ( 9 DOWNTO 0));
				END ENTITY Posicion_raq;
----------------------------------------------------------------
ARCHITECTURE fsm OF Posicion_raq IS
 signal pos_pre_s : integer range 524 downto 0; 
 signal pos_actual_s : integer range 524 downto 0; 
 
 begin 
 
 pos_pre_S <= CONV_INTEGER (pos_pre); 

PROCESS (E_Arriba,E_Abajo,clk)
BEGIN 

IF(rising_edge(clk)) THEN
	
  IF Actual = '1' THEN 
	 pos_actual_s <= 257;
			ELSIF E_Abajo = '1' THEN
				IF (pos_pre_s + 35 )< 465 THEN 
					pos_actual_s <= (pos_pre_s + 8);
				ELSE
					pos_actual_s <= pos_pre_s ;
				END IF;
			ELSIF E_Arriba = '1' THEN 
				IF (pos_pre_s -35)> 14 THEN 
					pos_actual_s <= (pos_pre_s - 8);	
				ELSE
					pos_actual_s <= pos_pre_s ;	
				END IF;	
			END IF;
	END IF;
	
END PROCESS;

pos_actual <= STD_LOGIC_VECTOR(TO_UNSIGNED (Pos_actual_s, 10));

END ARCHITECTURE fsm;