library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  
use IEEE.NUMERIC_STD.ALL;

entity calendar is
	port(CLOCK,RESET,CLOCK_SET: in std_logic;
	SET_ZI,SET_LUNA,SET_AN,AN_BISECT: in std_logic;
	AN_OUT,LUNA_OUT,ZI_OUT: out integer);
end calendar;

architecture arch_calendar of calendar is
signal zi: integer range 1 to 32;
signal luna: integer range 1 to 13;
signal an: integer range 2018 to 2100;
signal an_aux:integer;
begin  		  		  
	process(CLOCK,RESET,SET_ZI,SET_LUNA,SET_AN,CLOCK_SET)
	begin 
		 if CLOCK_SET'EVENT and CLOCK_SET='1' then
			if SET_AN='1' then
				if an=2100 then
					an<=2018;
				else	 
				an<=an+1;
				end if;
			elsif SET_LUNA='1' then
				if luna=12 then
					luna<=1;
				else
				luna<=luna+1;
				end if;
			elsif SET_ZI='1' then
				if zi=31 then
					zi<=1;
				else
				zi<=zi+1;
				end if;
			end if;
		end if;
		if RESET='1' then
			an<=2018;
			luna<=1;
			zi<=1;	
		elsif CLOCK'EVENT and CLOCK='1' then 
			if luna=1 or luna=3 or luna=5 or luna=7 or luna=8 or luna=10 or luna=12 then
				if zi=31 then
					zi<=1;
					luna<=luna+1;
					if luna=12 then
						zi<=1;
						luna<=1;
						an<=an+1;
					end if;
				else
					zi<=zi+1;
				end if;
			elsif luna=4 or luna=6 or luna=9 or luna=11 then						
				if zi=30 then
					zi<=1;
					luna<=luna+1;
				else
					zi<=zi+1; 
				end if;
			elsif luna=2 then
				if AN_BISECT='1' then
					if zi=29 then
						zi<=1;
						luna<=luna+1;
					else
						zi<=zi+1;
					end if;
				else
					if zi=28 then
						zi<=1;
						luna<=luna+1;
					else
						zi<=zi+1;  
					end if;
				end if;
			end if;
		end if;
	end process;
	AN_OUT<=an;
	LUNA_OUT<=luna;
	ZI_OUT<=zi;
end arch_calendar;
			
					
		
			