LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------
ENTITY Pong IS
	GENERIC ( N          : INTEGER  := 4);
	PORT    ( clk, b3, b4: IN  STD_LOGIC;
				 rst, b1, b2: IN  STD_LOGIC;
				 Play			: IN STD_LOGIC;
				 start		: IN STD_LOGIC;
				 puntoA		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				 puntoB		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				 vga_vs     : OUT STD_LOGIC;
				 vga_hs     : OUT STD_LOGIC;
				 vga_R      : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0); 
				 vga_G      : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0); 
				 vga_B      : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));

END ENTITY;
-------------------------------------------------------
-------------------------------------------------------
ARCHITECTURE rtl OF Pong IS 
SIGNAL bolay, bolax : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL pos_reg1, pos_reg2 : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL punto_a, punto_b, gameover, Jau, Jad, Jbu, Jbd, hab, empieza : STD_LOGIC;

BEGIN
	Pantalla: ENTITY WORK.control_VGA
			GENERIC MAP ( N => 4)
			PORT MAP (	clk 		=>clk,
							rst		=>rst,
							gameover	=>gameover,
							bolax		=>bolax,
							bolay		=>bolay,
							pos_reg1	=>pos_reg1,
							pos_reg2	=>pos_reg2,
							vga_vs	=>vga_vs,
							vga_hs	=>vga_hs,
							vga_R		=>vga_R, 
							vga_G		=>vga_G, 
							vga_B		=>vga_B);
		
	Jugadores: ENTITY WORK.Raquetas
			   PORT MAP(	clk		=> clk,
								rst 		=> rst,
								pausa    => Play,
								b1			=> Jau,
								b2			=> Jad,
								b3			=>	Jbu,
								b4     	=> Jbd,
								jugador1 => pos_reg1,
								jugador2	=> pos_reg2);
								
	Bola_mov: ENTITY WORK.Pelota
				PORT MAP( 	clk 			=> clk,
								rst 			=> empieza,
								pausa			=> Play,
								pt_a			=> punto_a,
								pt_b			=> punto_b,
								jugador1		=> pos_reg1,
								jugador2		=>	pos_reg2,
								pos_bola_x	=> bolax,
								pos_bola_y	=> bolay);
								
	control_juego: ENTITY WORK.Control
				PORT MAP( 	clk		=> clk,
								rst 		=> rst,
								start		=> NOT start,
								pt_a		=> punto_a,
								pt_b		=> punto_b,
								gameover	=> gameover,
								habilitador => hab,
								puntoA	=>	puntoA,
								puntoB	=> puntoB);
								
	Jau <= b1 AND (NOT b2);
	Jad <= b2 AND (NOT b1);
	
	Jbu <= b3 AND (NOT b4);
	Jbd <= b4 AND (NOT b3);
	
	empieza<= rst OR hab;
 
END ARCHITECTURE;