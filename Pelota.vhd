LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------
ENTITY Pelota IS
	PORT    ( clk			: IN  STD_LOGIC;
				 rst			: IN  STD_LOGIC;
				 pausa		: IN  STD_LOGIC;
				 jugador1   : IN	STD_LOGIC_VECTOR(9 DOWNTO 0);
				 jugador2   : IN	STD_LOGIC_VECTOR(9 DOWNTO 0);
				 pt_a, pt_b	: OUT	STD_LOGIC;
				 pos_bola_x : OUT STD_LOGIC_VECTOR(9 DOWNTO 0); 
				 pos_bola_y : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END ENTITY;
-------------------------------------------------------
-------------------------------------------------------
ARCHITECTURE rtl OF Pelota IS
	SIGNAL punto_a, punto_b, flg, ena_bol : STD_LOGIC;
	SIGNAL posicion_anterior_x, posicion_anterior_y	  : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL posicion_siguiente_x, posicion_siguiente_y : STD_LOGIC_VECTOR(9 DOWNTO 0);
BEGIN
	registro: ENTITY WORK.registro_bol
				PORT MAP ( 	clk	=> flg,	 
								rst 	=> rst,
								ena 	=> ena_bol,
								pa		=> punto_a,
								pb		=>	punto_b,
								d_x 	=> posicion_anterior_x,
								d_y 	=> posicion_anterior_y,
								q_x	=> posicion_siguiente_x,
								q_y 	=> posicion_siguiente_y);
								
	mov_bola: ENTITY WORK.Control_bol
				PORT MAP (	clk		=> clk,
								rst		=> rst,
								jugador1	=> jugador1,
								jugador2 => jugador2,
								pos_pv_x	=> posicion_siguiente_x,
								pos_pv_y	=> posicion_siguiente_y,
								punto_a	=> punto_a, 
								punto_b	=> punto_b,
								pos_sg_x	=> posicion_anterior_x,
								pos_sg_y	=> posicion_anterior_y);
								
	contador: ENTITY work.univ_bin_counter		
					GENERIC MAP(	N	=> 20)
						PORT MAP(	clk	=>	clk,
										rst	=> rst,
										ena => '1',
										syn_clr	=> rst,
										limit	=>	X"7A120", 	--1ms--
										max_tick	=> flg);
										
	boton: ENTITY WORK.debounce
			PORT MAP(clk		=> clk,		
						rst		=> rst,
						sw			=> NOT pausa,
						deb_sw	=> ena_bol);
	
	pt_a <= punto_a;
	pt_b <= punto_b;
	
	pos_bola_x <= posicion_siguiente_x;
	pos_bola_y <= posicion_siguiente_y;

END ARCHITECTURE;