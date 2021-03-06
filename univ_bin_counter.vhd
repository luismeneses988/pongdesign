LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-----------------------------------------------------------------------------
ENTITY univ_bin_counter IS
	GENERIC	(	N			:	INTEGER	:=	4);
	PORT		(	clk, rst		:	IN		STD_LOGIC;
					ena		:	IN		STD_LOGIC;
					syn_clr	:	IN		STD_LOGIC;
					limit		:	IN		STD_LOGIC_VECTOR(N-1 DOWNTO 0);
					max_tick	:	OUT	STD_LOGIC;
					min_tick	:	OUT	STD_LOGIC;
					counter	:	OUT	STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY;
------------------------------------------------------------------------------
ARCHITECTURE rtl	OF univ_bin_counter IS
	SIGNAL ONES				:	UNSIGNED (N-1 DOWNTO 0);
	CONSTANT ZEROS			:	UNSIGNED (N-1 DOWNTO 0)	:= (OTHERS => '0');
	
	SIGNAL	count_s		:	UNSIGNED (N-1 DOWNTO 0);
	SIGNAL	count_next	:	UNSIGNED (N-1 DOWNTO 0);
	
BEGIN
	--NEXT STATE LOGIC
	count_next	<=		(OTHERS => '0')	WHEN (count_s = ONES-1)	      ELSE					
							count_s + 1			WHEN (ena ='1') 	ELSE
							count_s;
	PROCESS(clk, rst, syn_clr)
	VARIABLE temp	:	UNSIGNED(N-1 DOWNTO 0);
		BEGIN
			IF (rst='1') THEN
				temp := (OTHERS => '0');
				ELSIF (rising_edge(clk)) THEN
					IF (syn_clr = '1') THEN
						temp := (OTHERS => '0');
					END IF;
						IF(ena='1') THEN
							temp	:= count_next;
						END IF;
			END IF;
			counter	<=	STD_LOGIC_VECTOR(temp);
			count_s	<= temp;
		END PROCESS;
		
		--OUTPUT LOGIC
		ONES 		<= UNSIGNED(limit);
		max_tick	<=	'1' WHEN count_s = ONES-1	ELSE '0';
		min_tick <= '1' WHEN count_s = ZEROS	ELSE '0';
		
END ARCHITECTURE;