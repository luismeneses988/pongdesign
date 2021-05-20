library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity image_generator is
Port (	horizontal 	: in STD_LOGIC_VECTOR (9 downto 0);
			vertical 	: in std_logic_vector (9 downto 0);
			ver 			: in std_logic; -- blank interval signal
			clk 			: in std_logic; -- main clock
			rst 			: in std_logic; -- global reset
			pos_bolaxp: in std_logic_vector(9 DOWNTO 0); -- global reset  
			pos_bolayp: in std_logic_vector(9 DOWNTO 0); -- global reset 
			pos_raq_1: in std_logic_vector(9 DOWNTO 0); -- global reset  
			pos_raq_2: in std_logic_vector(9 DOWNTO 0); -- global reset 
			R 				: out std_logic; -- Red colour signal
			G 				: out std_logic; -- Green colour signal
			B 				: out std_logic); -- Blue colour signal
end image_generator;

architecture Behavioral of image_generator is
	SIGNAL hctr_int : integer range 799 downto 0;
	SIGNAL vctr_int : integer range 524 downto 0;
	SIGNAL R_int, G_int, B_int: std_logic;
	SIGNAL color: std_logic_vector (2 downto 0);
	SIGNAL pos_reg_s1,pos_reg_s2,pos_regyp_s, pos_regxp_s : integer range 524 DOWNTO 0;
	
BEGIN
	hctr_int <= CONV_INTEGER (horizontal);
	vctr_int <= CONV_INTEGER (vertical);
	
	pos_reg_s1 <= CONV_INTEGER (pos_raq_1);
	pos_regyp_s <= CONV_INTEGER (pos_bolayp);
	pos_regxp_s <= CONV_INTEGER (pos_bolaxp);
	pos_reg_s2 <= CONV_INTEGER (pos_raq_2);	
---------------------------------------------	
PROCESS (clk,rst,R_int,G_int,B_int)
BEGIN
	IF rst = '1' THEN
		R <= '0';
		G <= '0';
		B <= '0';
	ELSIF clk='1' AND clk'event THEN
		R <= R_int;
		G <= G_int;
		B <= B_int;
	END IF;
END PROCESS;
-----------------------------------------------------------------------------------		
color <= "101" when ((hctr_int >= 25) AND (hctr_int < 30) AND  (vctr_int >= (pos_reg_s1-35)) AND (vctr_int < (pos_reg_s1 + 35))  AND (ver = '1')) else
			"101" when ((hctr_int >= 610) AND (hctr_int < 615) AND  (vctr_int >= (pos_reg_s2-35)) AND (vctr_int < (pos_reg_s2 + 35))  AND (ver = '1')) else
			-----------------------------------------------------------------------------------
			"100" when ((hctr_int >= pos_regxp_s - 6) AND (hctr_int < pos_regxp_s + 6) AND  (vctr_int >= pos_regyp_s -4) AND (vctr_int < pos_regyp_s + 4)  AND (ver = '1')) else

			"110" when ((hctr_int >= 0) AND (hctr_int < 800) AND  (vctr_int >= 5 ) AND (vctr_int < 15)  AND (ver = '1')) else
			"110" when ((hctr_int >= 0) AND (hctr_int < 800) AND  (vctr_int >= 465 ) AND (vctr_int < 470)  AND (ver = '1')) else
			"110" when ((hctr_int >= 15) AND (hctr_int < 20) AND  (vctr_int >= 5 ) AND (vctr_int < 470)  AND (ver = '1')) else
			"110" when ((hctr_int >= 620) AND (hctr_int < 625) AND  (vctr_int >= 5 ) AND (vctr_int < 470)  AND (ver = '1')) else

			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 0   ) AND (vctr_int < 15)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 30  ) AND (vctr_int < 45)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 60  ) AND (vctr_int < 75)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 90  ) AND (vctr_int < 105)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 120 ) AND (vctr_int < 135)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 150 ) AND (vctr_int < 165)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 180 ) AND (vctr_int < 195)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 210 ) AND (vctr_int < 225)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 240 ) AND (vctr_int < 255)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 270 ) AND (vctr_int < 285)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 300 ) AND (vctr_int < 315)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 330 ) AND (vctr_int < 345)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 360 ) AND (vctr_int < 375)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 390 ) AND (vctr_int < 405)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 420 ) AND (vctr_int < 435)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 450 ) AND (vctr_int < 465)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 480 ) AND (vctr_int < 495)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 510 ) AND (vctr_int < 525)  AND (ver = '1')) else
			"111" when ((hctr_int >= 318) AND (hctr_int < 322) AND  (vctr_int >= 540 ) AND (vctr_int < 555)  AND (ver = '1')) else
			"000" ;

 R_int <= color(2);
 G_int <= color(1); 
 B_int <= color(0); 
 end Behavioral;

