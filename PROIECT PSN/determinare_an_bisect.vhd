library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  
use IEEE.NUMERIC_STD.ALL;

entity det_an_bisect is
	port(AN: in integer;
	AN_BISECT: out std_logic);
end det_an_bisect;

architecture arch_det_an_bisect of det_an_bisect is
signal AN_AUX:integer:=0;
begin
	AN_AUX<=AN;
	AN_BISECT<='1' when AN_AUX mod 400=0 else
			   '1' when AN_AUX mod 400/=0 and AN_AUX mod 4=0 else
			   '0' when AN_AUX mod 400/=0 and AN_AUX mod 100=0 else
			   '0';
end arch_det_an_bisect;
	