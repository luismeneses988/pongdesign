LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------
ENTITY generador IS
	GENERIC ( N          : INTEGER  := 12);
	PORT    ( horizontal : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				 vertical   : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				 vsync   	: OUT STD_LOGIC;
				 hsync     	: OUT STD_LOGIC);
END ENTITY;	

ARCHITECTURE rtl OF generador IS

BEGIN

process(horizontal, vertical)
 begin
   if (horizontal <= "1010001111") then --655
		hsync <= '1';
	else
      if(horizontal >= "101110111") then --750	
			hsync <= '1';
		else
			hsync <= '0';
		end if;
	end if;
	
	if (vertical <= "0111101001") then --489
		vsync <= '1';
		else
			if (vertical >= "0111101011") then --490
				vsync <= '1';
			else
				vsync <= '0';
			end if;
	end if;
 end process;
					 
END ARCHITECTURE;