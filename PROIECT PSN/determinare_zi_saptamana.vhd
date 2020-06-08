library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  
use IEEE.NUMERIC_STD.ALL;

entity det_zi_sapt is
	port(AN: in integer;
	LUNA: in integer;
	ZI: in integer;
	W: inout integer);
end det_zi_sapt;

architecture arch_det_zi_sapt of det_zi_sapt is
signal t:integer:=0;
signal an_int:integer:=0;
signal luna_int:integer:=0;
signal zi_int:integer:=0;
signal an_int_aux:integer:=0;	  
signal w_int:integer:=0;
signal AN_AUX:integer:=0;
begin
	AN_AUX<=AN-1;		
	an_int<=AN;
	luna_int<=LUNA-1;
	zi_int<=ZI;
	an_int_aux<=AN_AUX;	
t<=0 when luna_int=0 or luna_int=4 else
	1 when luna_int=7 else
	2 when luna_int=2 or luna_int=10 else
	3 when luna_int=1 or luna_int=5 else
	4 when luna_int=8 or luna_int=11 else
	5 when luna_int=3 or luna_int=6 else
	6 when luna_int=9;
	w_int<=(an_int_aux+an_int_aux/4-an_int_aux/100+an_int_aux/400+t+zi_int)mod 7 when luna_int<2 else
	   (an_int+an_int/4-an_int/100+an_int/400+t+zi_int)mod 7;	
	W<=w_int;
end arch_det_zi_sapt;