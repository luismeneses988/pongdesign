----------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
----------------------------------------------------------------
ENTITY  Control_bol IS
	PORT	(	clk					:	IN		STD_LOGIC;
				rst					:	IN		STD_LOGIC;
				pos_pv_x				:	IN		STD_LOGIC_VECTOR(9 DOWNTO 0);
				pos_pv_y				:	IN		STD_LOGIC_VECTOR(9 DOWNTO 0);
				jugador1   			: 	IN	STD_LOGIC_VECTOR(9 DOWNTO 0);
				jugador2   			: 	IN	STD_LOGIC_VECTOR(9 DOWNTO 0);
				punto_a, punto_b	:	OUT	STD_LOGIC;
				pos_sg_x				:	OUT   STD_LOGIC_VECTOR(9 DOWNTO 0);
				pos_sg_y				:	OUT   STD_LOGIC_VECTOR(9 DOWNTO 0));
END ENTITY Control_bol;
----------------------------------------------------------------
ARCHITECTURE fsm OF Control_bol IS
	TYPE state IS (down_left,up_left,up_right,down_right);
	SIGNAL pr_state, next_state	:	state;
	SIGNAL pr_aux_x, nx_aux_x : INTEGER RANGE 640 DOWNTO 0;
	SIGNAL pr_aux_y, nx_aux_y, pos_rqa, pos_rqb : INTEGER RANGE 480 DOWNTO 0;
BEGIN

	pr_aux_x <= CONV_INTEGER (pos_pv_x); 
	pr_aux_y <= CONV_INTEGER (pos_pv_y);
	
	pos_rqa <= CONV_INTEGER (jugador1);
	pos_rqb <= CONV_INTEGER (jugador2);
	
	sequential: PROCESS(rst, clk)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	up_left;
		ELSIF (rising_edge(clk)) THEN
			pr_state	<=	next_state;
		END IF;
	END PROCESS sequential;

	combinational: PROCESS(pr_state, pr_aux_x, pr_aux_y, pos_rqa, pos_rqb)
	BEGIN
		CASE pr_state IS
			
	WHEN down_left	=>
				punto_a <= '0';
				punto_b <= '0';
				IF ((pr_aux_y + 4) > 465) THEN
					next_state <= up_left;
					nx_aux_y <= pr_aux_y - 1;
					nx_aux_x <= pr_aux_x - 1;
				ELSIF ((pr_aux_x - 6) = 27) THEN
					IF ( ((pr_aux_y + 4) < (pos_rqa + 37)) AND ((pr_aux_y - 4) > (pos_rqa - 37)) ) THEN 
							next_state <= down_right;
							nx_aux_y <= pr_aux_y + 1;
							nx_aux_x <= pr_aux_x + 1;
						ELSE
							punto_b <= '1';
							next_state <= down_right;
							nx_aux_y <= pr_aux_y + 1;
							nx_aux_x <= pr_aux_x + 1;	
					END IF;
				ELSE
					next_state <= down_left;
					nx_aux_y <= pr_aux_y + 1;
					nx_aux_x <= pr_aux_x - 1;
				END IF;					
				 
	WHEN up_left	=>
				punto_a <= '0';
				punto_b <= '0';
				IF ((pr_aux_y - 4) < 15) THEN
					next_state <= down_left;
					nx_aux_y <= pr_aux_y + 1;
					nx_aux_x <= pr_aux_x - 1;
				ELSIF ((pr_aux_x - 6) = 27) THEN
					IF ( ((pr_aux_y + 4) < (pos_rqa + 37)) AND ((pr_aux_y - 4) > (pos_rqa - 37)) ) THEN 
							next_state <= up_right;
							nx_aux_y <= pr_aux_y - 1;
							nx_aux_x <= pr_aux_x + 1;
						ELSE
							punto_b <= '1';
							next_state <= up_right;
							nx_aux_y <= pr_aux_y - 1;
							nx_aux_x <= pr_aux_x + 1;	
					END IF;		
				ELSE
					next_state <= up_left;
					nx_aux_y <= pr_aux_y - 1;
					nx_aux_x <= pr_aux_x - 1;
				END IF;	
					
	WHEN up_right	=>
				punto_a <= '0';
				punto_b <= '0';
				IF ((pr_aux_y - 4) < 15) THEN -- Si la margen de la bola por arriba llega a la margen superior del fondo
					next_state <= down_right;
					nx_aux_y <= pr_aux_y + 1;
					nx_aux_x <= pr_aux_x + 1;
				ELSIF ((pr_aux_x + 6) = 610) THEN  -- Si la margen derecha de la bola llega a la margen derecha del fondo
					IF ( ((pr_aux_y + 4) < (pos_rqb + 37)) AND ((pr_aux_y - 4) > (pos_rqb - 37)) ) THEN 
							next_state <= up_left;
							nx_aux_y <= pr_aux_y - 1;
							nx_aux_x <= pr_aux_x - 1;
						ELSE
							punto_a <= '1';
							next_state <= up_left;
							nx_aux_y <= pr_aux_y - 1;
							nx_aux_x <= pr_aux_x - 1;	
					END IF;		
				ELSE
					next_state <= up_right;
					nx_aux_y <= pr_aux_y - 1;
					nx_aux_x <= pr_aux_x + 1;
				END IF;
				
	WHEN down_right	=>
				punto_a <= '0';
				punto_b <= '0';
				IF ((pr_aux_y + 4) > 465) THEN
					next_state <= up_right;
					nx_aux_y <= pr_aux_y - 1;
					nx_aux_x <= pr_aux_x + 1;
				ELSIF((pr_aux_x + 6) = 610) THEN
					IF ( ((pr_aux_y + 4) < (pos_rqb + 37)) AND ((pr_aux_y - 4) > (pos_rqb - 37)) ) THEN 
							next_state <= down_left;
							nx_aux_y <= pr_aux_y + 1;
							nx_aux_x <= pr_aux_x - 1;
						ELSE
							punto_a <= '1';
							next_state <= down_left;
							nx_aux_y <= pr_aux_y - 1;
							nx_aux_x <= pr_aux_x - 1;	
					END IF;
				ELSE
					next_state <= down_right;
					nx_aux_y <= pr_aux_y + 1;
					nx_aux_x <= pr_aux_x + 1;
				END IF;
				
		END CASE;
	END PROCESS combinational;
	
	pos_sg_x <=	STD_LOGIC_VECTOR(TO_UNSIGNED (nx_aux_x, 10));
	pos_sg_y <= STD_LOGIC_VECTOR(TO_UNSIGNED (nx_aux_y, 10));
	
END ARCHITECTURE fsm;