LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------
ENTITY control_VGA IS
	GENERIC ( N          : INTEGER  := 4);
	PORT    ( clk			: IN  STD_LOGIC;
				 rst			: IN  STD_LOGIC;
				 gameover	: IN  STD_LOGIC;
				 bolax		: IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
				 bolay		: IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
				 pos_reg1	: IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
				 pos_reg2	: IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
				 vga_vs     : OUT STD_LOGIC;
				 vga_hs     : OUT STD_LOGIC;
				 vga_R      : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0); 
				 vga_G      : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0); 
				 vga_B      : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));

END ENTITY;
-------------------------------------------------------
-------------------------------------------------------
ARCHITECTURE rtl OF control_VGA IS
SIGNAL flg1, lectura_b, lectura_mem_blue, clk_out, grafica, r, g, b : STD_LOGIC; 
SIGNAL cont_h, cont_v : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL rom_data, in_memory_red, in_memory_blue, ram_blue: STD_LOGIC_VECTOR(639 DOWNTO 0);
SIGNAL color : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL aux_R, aux_G, aux_B, r_aux, g_aux, b_aux : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

process(clk)
begin
if( rising_edge(clk)) then 
clk_out <= not clk_out;
end if;
end process;

	horizontal: ENTITY work.univ_bin_counter
			GENERIC MAP(	N	=> 10)
			PORT MAP(	clk		=>	clk_out,
							rst		=> rst,
							ena 		=> '1',
							syn_clr	=> rst,
							limit		=>	"1100100000", 	--800--
							max_tick	=> flg1,
							counter 	=> cont_h);
							
	vertical: ENTITY work.univ_bin_counter
			GENERIC MAP(	N	=> 10)
			PORT MAP(	clk		=>	clk_out,
							rst		=> rst,
							ena 		=> flg1,
							syn_clr	=> rst,
							limit		=>	"1000001101", 	--525--
							counter 	=> cont_v);	 
							
	sincronismo: ENTITY work.generador
			GENERIC MAP(	N	=> 10)
			PORT MAP(	horizontal	=>	cont_h,
							vertical 	=> cont_v,
							hsync			=> vga_hs,
							vsync			=>	vga_vs);
							
	Visualiza: ENTITY work.Pantalla
		   port map(con_h	  	=> cont_h,
						con_v 	=> cont_v,		
						visible	=> grafica);
					
	memoria2: ENTITY work.ram_azul
		   port map(clock	  => clk,
						address => cont_v(8 DOWNTO 0),		
						q		  => ram_blue);
					
	Background: ENTITY work.image_generator
		   PORT MAP(	horizontal	=> cont_h,
							vertical		=> cont_v,
							ver			=> grafica,
							clk			=> clk,
							rst			=>	rst,
							pos_bolaxp	=> bolax,  
							pos_bolayp	=> bolay, 
							pos_raq_1	=> pos_reg1,  
							pos_raq_2	=> pos_reg2,	
							R				=> r,
							G				=> g,
							B				=> b);
	
lectura_mem_blue <= in_memory_blue(to_integer(unsigned(cont_h)));

in_memory_blue <= ram_blue;

lectura_b <= lectura_mem_blue;

vga_B <= aux_B WHEN (gameover = '1') ELSE b_aux;
vga_G <= aux_G WHEN (gameover = '1') ELSE g_aux;
vga_R <= aux_R WHEN (gameover = '1') ELSE r_aux;


b_aux <= "1111" when (r = '1') else 
			"0000";
g_aux <= "1111" when (g = '1') else 
			"0000";
r_aux <= "1111" when (b = '1') else 
			"0000";
			
aux_B <= "1111" when (lectura_b = '1') else
         "0000";
aux_G <= "1111" when (lectura_b = '1') else
         "0000";
aux_R <= "1111" when (lectura_b = '1') else
         "0000";
					 
END ARCHITECTURE;