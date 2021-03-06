LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------
ENTITY Raquetas IS
	GENERIC ( N          : INTEGER  := 4);
	PORT    ( clk, b3, b4: IN  STD_LOGIC;
				 rst, b1, b2: IN  STD_LOGIC;
				 pausa		: IN  STD_LOGIC;
				 jugador1   : OUT STD_LOGIC_VECTOR(9 DOWNTO 0); 
				 jugador2   : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END ENTITY;
-------------------------------------------------------
-------------------------------------------------------
ARCHITECTURE rtl OF Raquetas IS 
SIGNAL Actual_S1, Actual_S2, E_arriba_s1, E_abajo_s1, E_arriba_s2, E_abajo_s2: STD_LOGIC;
SIGNAL pos_reg1, pos_reg2, pos_actual_s_1, pos_actual_s_2 : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL reset_s1, reset_s2, ena_reg_s1, ena_reg_s2, ena_raq, ena_raqA, ena_raqB : STD_LOGIC;
SIGNAL arriba_raq1, arriba_raq2, abajo_raq1, abajo_raq2, clr, flg: STD_LOGIC;

BEGIN		
	controll: ENTITY WORK.Control_raq
			   PORT MAP(	clk				=> clk,
								rst 				=> rst,
								Arriba			=> arriba_raq1,
								Abajo				=> abajo_raq1,
								E_Arriba			=>	E_Arriba_s1,
								E_Abajo     	=> E_Abajo_s1,
								reset_R        => reset_s1,
								ena_reg			=> ena_reg_s1,
								actual	      => Actual_S1);
								
	control2: ENTITY WORK.Control_raq
			   PORT MAP(	clk				=> clk,
								rst 				=> rst,
								Arriba			=> arriba_raq2,
								Abajo				=> abajo_raq2,
								E_Arriba			=>	E_Arriba_s2,
								E_Abajo     	=> E_Abajo_s2,
								reset_R        => reset_s2,
								ena_reg			=> ena_reg_s2,
								actual	      => Actual_S2);
							
	pos_r1: ENTITY WORK.Posicion_raq
			   PORT MAP(	Actual			=> Actual_S1,
								Clk				=> clk,	
								Pos_Pre			=> pos_reg1,
								E_Arriba 		=> E_Arriba_s1,
								E_Abajo			=> E_Abajo_s1,
								Pos_actual		=> pos_actual_s_1);
					
	pos_r2: ENTITY WORK.Posicion_raq
			   PORT MAP(	Actual			=> Actual_S2,
								Clk 				=> clk,	
								Pos_Pre			=> pos_reg2,
								E_Arriba 		=> E_Arriba_s2,
								E_Abajo			=> E_Abajo_s2,
								Pos_actual		=> pos_actual_s_2);
	
	reg_1: ENTITY WORK.registro_raq
			   PORT MAP(	clk		=> flg,
								rst 		=> reset_s1,
								ena     	=> ena_raqA, 
								d			=> pos_actual_s_1,
								q			=> pos_reg1);		
								
	reg_2: ENTITY WORK.registro_raq
			   PORT MAP(	clk		=> flg,
								rst 		=> reset_s2,
								ena     	=> ena_raqB, 
								d			=> pos_actual_s_2,
								q			=> pos_reg2);	
	
	
	contador: ENTITY work.univ_bin_counter		
					GENERIC MAP(	N	=> 24)
						PORT MAP(		clk	=>	clk,
											rst	=> rst,
											ena => '1',
											syn_clr	=> '0',
											limit	=>	X"1E8480", 	--5ms--
											max_tick	=> flg);
											
	boton: ENTITY WORK.debounce
			PORT MAP(clk		=> clk,		
						rst		=> rst,
						sw			=> NOT pausa,
						deb_sw	=> ena_raq);

ena_raqA <= ena_raq AND ena_reg_s1;
ena_raqB	<= ena_raq AND ena_reg_s2;					
				
arriba_raq1<= b1;
abajo_raq1 <= b2;
arriba_raq2<= b3;
abajo_raq2 <= b4;

jugador1 <= pos_reg1;
jugador2 <= pos_reg2;	
					 
END ARCHITECTURE;	