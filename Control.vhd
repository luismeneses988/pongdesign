LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------
ENTITY Control IS
	PORT    ( rst, clk	: IN  STD_LOGIC;
				 start		: IN	STD_LOGIC;
				 pt_a     	: IN STD_LOGIC;
				 pt_b     	: IN STD_LOGIC;
				 gameover 	: OUT	STD_LOGIC;
				 habilitador: OUT	STD_LOGIC;
				 puntoA		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				 puntoB		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));

END ENTITY;
-------------------------------------------------------
-------------------------------------------------------
ARCHITECTURE rtl OF control IS 
	SIGNAL cont1, cont2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL flg1, flg2, fin, reset, reinicio, act : STD_LOGIC;
	
BEGIN
	puntajeA: ENTITY WORK.bin_to_sseg
				PORT MAP( 	bin 			=> cont1,
								sseg 			=> puntoA);
								
	puntajeB: ENTITY WORK.bin_to_sseg
				PORT MAP( 	bin 			=> cont2,
								sseg 			=> puntoB);
	
	conteo1: ENTITY work.univ_bin_counter		
					GENERIC MAP(	N	=> 4)
						PORT MAP(	clk		=>	pt_a,
										rst		=> reinicio,
										ena 		=> act,
										syn_clr	=> fin,
										limit		=>	X"3",
										max_tick	=> flg1,
										counter	=> cont1);
	
	conteo2: ENTITY work.univ_bin_counter		
					GENERIC MAP(	N	=> 4)
						PORT MAP(	clk		=>	pt_b,
										rst 		=> reinicio,
										ena 		=> act,
										syn_clr	=> fin,
										limit		=>	X"3",
										max_tick	=> flg2,
										counter	=> cont2);
										
	estado: ENTITY work.estados
				PORT MAP(clk	=> clk,
							rst	=> rst,
							fin	=>	fin,
							start => start,
							ena	=> act,
							hab	=> habilitador,
							gameover=> gameover);
	fin <= (flg1 OR flg2);
	reinicio <= rst OR start;
 
END ARCHITECTURE;