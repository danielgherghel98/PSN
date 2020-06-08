library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  
use IEEE.NUMERIC_STD.ALL;

entity ceas is
	port(SET_MIN,SET_ORA,START,RESET,CLOCK: in std_logic;
	TC: out std_logic;
	ORA,MINUT: out integer);
end ceas;

architecture arch_ceas of ceas is
signal sec,min: integer range 0 to 60:=0;
signal h: integer range 0 to 24:=0;
begin  
	process(CLOCK,RESET,SET_MIN,SET_ORA,START)
	begin 
		if h=23 and min=59 and sec=59 then --daca am ajuns la 23:59:59 TC devine 1
			TC<='1';
		else--altfel ramane 0 
			TC<='0';
		end if;
			if RESET='1' then --resetez ceasul
				sec<=0;
				min<=0;
				h<=0;	
		elsif CLOCK'EVENT and CLOCK='1' then --daca reset=0 
			if SET_MIN='1' then 	 --setez minutul
			min<=min+1;
			if min=59 then
				min<=0;
			end if;
		    elsif SET_ORA='1' then -- setez ora
			h<=h+1;
				if h=23 then
					h<=0;
				end if;
			end if;	
			if SET_ORA='0' and SET_MIN='0' then -- daca nu setez ora si minutul incep sa numar
			TC<='0';
			sec<=sec+1;
			if sec=59 then	 
				min<=min+1;
				sec<=0;
				if min=59 then
					h<=h+1;
					min<=0;
					if h=23 then
						h<=0;
					end if;
				end if;
			end if;
		end if;
		end if;
	end process;
	ORA<=h when START='1';
	MINUT<=min when START='1';
end arch_ceas;