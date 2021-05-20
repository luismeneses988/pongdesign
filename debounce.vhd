LIBRARY IEEE;
USE ieee.std_logic_1164.all;
---------------------------------
ENTITY debounce IS
	PORT	(	clk	:	IN	STD_LOGIC;
			sw, rst	:	IN	STD_LOGIC;
			deb_sw :	OUT	STD_LOGIC);
END ENTITY debounce;
---------------------------------
ARCHITECTURE fsm OF debounce IS
	SIGNAL out_0, out_1, out_2, flg, clr, ena_1 : STD_LOGIC;
BEGIN
	contador: ENTITY work.univ_bin_counter		
					GENERIC MAP(	N	=> 24)
						PORT MAP(		clk	=>	clk,
											rst	=> rst,
											ena => ena_1,
											syn_clr	=> clr,
											limit	=>	X"2625A0", 	--5ms--
											max_tick	=> flg);
											
	FSM: ENTITY work.debounce_FSM
		PORT MAP	(	clk => clk,
						rst => rst,
						timerFlag => flg,
						button	=> sw,
						output	=> out_0,
						ena_t		=> ena_1,
						clr => clr);
						
	FF: ENTITY work.my_dff
		PORT MAP (	clk	=> out_0,
						rst	=> rst,
						en		=> '1',
						d		=> out_2, 
						q		=> out_1);
	out_2<=NOT(out_1);
	deb_sw <= out_1;
END ARCHITECTURE;	