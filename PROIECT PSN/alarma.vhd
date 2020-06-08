library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  
use IEEE.NUMERIC_STD.ALL;

entity alarma is
	port(CLOCK,A_START,A_RESET,A_SET_MIN,A_SET_ORA: in std_logic;
	ORA_ACT,MIN_ACT: in integer;
	SONERIE: out std_logic;
	ORA_ALARMA,MINUT_ALARMA: out integer);
end alarma;

architecture arch_alarma of alarma is
signal a_min: integer range 0 to 60:=0;
signal a_h: integer range 0 to 24:=0;	
signal son: std_logic;
begin
	process(CLOCK,A_RESET,A_SET_MIN,A_SET_ORA,A_START,ORA_ACT,MIN_ACT)
	begin
		if A_RESET='1' then
			a_min<=0;
			a_h<=0;
		elsif CLOCK'EVENT and CLOCK='1' then
			if A_SET_MIN='1' then
				a_min<=a_min+1;
			if a_min=59 then
				a_min<=0;
			end if;
			elsif A_SET_ORA='1' then
				a_h<=a_h+1;
				if a_h=23 then
					a_h<=0;
				end if;
			end if;
		end if;		  
		if a_h=ORA_ACT and a_min=MIN_ACT and A_START='1' then
			son<='1';
		end if;
	end process;
	SONERIE<=son;  
	ORA_ALARMA<=a_h;
	MINUT_ALARMA<=a_min;
end arch_alarma;

	
