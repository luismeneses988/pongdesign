----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------------
ENTITY  Control_raq IS
	PORT	(	clk					:	IN		STD_LOGIC;
				rst					:	IN		STD_LOGIC;
				Arriba				:	IN		STD_LOGIC;
				Abajo					:	IN		STD_LOGIC;
				E_Arriba				:	OUT   STD_LOGIC;
				E_Abajo				:	OUT	STD_LOGIC;
				reset_r    			: 	OUT 	STD_LOGIC;
				ena_reg				:	OUT   STD_LOGIC;
				actual				:  OUT 	STD_LOGIC);
END ENTITY Control_raq;
----------------------------------------------------------------
ARCHITECTURE fsm OF Control_raq IS
	TYPE state IS (s0,s1,s2,s3);
	SIGNAL pr_state, next_state	:	state;
BEGIN
	sequential: PROCESS(rst, clk)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	s0;
		ELSIF (rising_edge(clk)) THEN
			pr_state	<=	next_state;
		END IF;
	END PROCESS sequential;

	combinational: PROCESS(pr_state, Arriba,Abajo)
	BEGIN
		CASE pr_state IS
			
	WHEN s0	=>
				E_Abajo <= '0';
				E_Arriba <= '0';
				reset_r<= '1';
				ena_reg <= '0';
				actual <= '1';
				next_state <= s1; 
			
	WHEN s1	=>
				E_Abajo <= '0';
				E_Arriba <= '0';
				reset_r<= '0';
				ena_reg <= '0';
			   actual <= '0';
				IF (Arriba = '1') THEN
					next_state <= s1;
					actual <= '0';
					reset_r<= '0';
					E_Abajo <= '0';
					E_Arriba <= '1';
					ena_reg <= '1';
				ELSIF (Abajo = '1') THEN
					next_state <= s1;
					actual <= '0';
					reset_r<= '0';
					E_Abajo <= '1';
					E_Arriba <= '0';
					ena_reg <= '1';	
			   ELSE
				 next_state <= s1; 
				END IF;
					
	WHEN s2	=>
				actual <= '0';
				reset_r<= '0';
				E_Abajo <= '0';
				E_Arriba <= '1';
				ena_reg <= '1';
				next_state <= s1;
				
	WHEN s3	=>
				actual <= '0';
				reset_r<= '0';
				E_Abajo <= '1';
				E_Arriba <= '0';
				ena_reg <= '1';
				next_state <= s1;
				
		END CASE;
	END PROCESS combinational;
END ARCHITECTURE fsm;