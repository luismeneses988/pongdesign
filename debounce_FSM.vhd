LIBRARY IEEE;
USE ieee.std_logic_1164.all;
---------------------------------
ENTITY debounce_FSM IS
	PORT	(	clk	:	IN	STD_LOGIC;
			rst, timerFlag, button	:	IN	STD_LOGIC;
			output, ena_t, clr :	OUT	STD_LOGIC);
END ENTITY debounce_FSM;
---------------------------------
ARCHITECTURE fsm OF debounce_FSM IS
	TYPE state is (st_0, st_1, st_2);
	SIGNAL	pr_state, nx_state: state;
BEGIN
------FSM-----
	PROCESS (clk, rst)
	BEGIN
		IF	(rst='1')	THEN
			pr_state <= st_0;
		ELSIF	(RISING_EDGE(clk))	THEN
			pr_state <= nx_state;
		END IF;
	END PROCESS;
	
	PROCESS (pr_state, timerFlag, button)
	BEGIN
		case pr_state is
			WHEN st_0 =>
				output <= '0';
				IF (button ='0') THEN
					ena_t <= '0';
					clr <= '1';
					nx_state <= st_0;
				ELSE 
					ena_t <= '1';
					clr <= '0';
					nx_state <= st_1; 
				END IF;
			WHEN st_1 =>
				output <= '0';
				IF (button ='0') then
					ena_t <= '0';
					clr <= '1';
					nx_state <= st_0;
				ELSE
					IF (timerFlag='0') THEN 
						ena_t <= '1';
						clr <= '0';
						nx_state <= st_1; 
					ELSE
						ena_t <= '0';
						clr <= '1';
						nx_state <= st_2; 
					END IF;
				END IF;
		WHEN st_2 =>
				output <= '1';
				ena_t<='0';
				clr<='1';
				IF (button ='0') then
					nx_state <= st_0;
				ELSE 
					
					nx_state<=st_2;
				END IF;
		END CASE;
	END PROCESS;			
		
END ARCHITECTURE;