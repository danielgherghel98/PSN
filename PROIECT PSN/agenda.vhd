library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  
use IEEE.NUMERIC_STD.ALL;

entity agenda is
	port(c_set_minut,c_set_ora,c_on_off,c_reset,set_zi,set_luna,set_an,clock,reset_calendar: in std_logic;
	a_set_minut,a_set_ora,a_on_off,a_reset: in std_logic;
	an_bisect: inout std_logic;
	an,zi,luna,ora,minut: inout integer;
	ora_alarma,minut_alarma: out integer;
	sonerie: out std_logic;
	temp_out: out integer);
end agenda;

architecture arch_agenda of agenda is
signal TC_ceas:std_logic;
signal ora_aux,minut_aux,zi_sapt_integer: integer:=0;
signal zi_sapt_string: string(1 to 2); 
signal an_aux,luna_aux,zi_aux: integer:=0;
signal temp: integer:=0;
--componente--
component calendar is
	port(CLOCK,RESET,CLOCK_SET: in std_logic;
	SET_ZI,SET_LUNA,SET_AN,AN_BISECT: in std_logic;
	AN_OUT,LUNA_OUT,ZI_OUT: out integer);
end component;

component ceas is
	port(SET_MIN,SET_ORA,START,RESET,CLOCK: in std_logic;
	TC: out std_logic;
	ORA,MINUT: out integer);
end component;

component alarma is
	port(CLOCK,A_START,A_RESET,A_SET_MIN,A_SET_ORA: in std_logic;
	ORA_ACT,MIN_ACT: in integer;
	SONERIE: out std_logic;
	ORA_ALARMA,MINUT_ALARMA: out integer);
end component;

component det_zi_sapt is
	port(AN: in integer;
	LUNA: in integer;
	ZI: in integer;
	W: inout integer);
end component; 

component det_an_bisect is
	port(AN: in integer;
	AN_BISECT: inout std_logic);
end component;

component temperatura is
	port(t: out integer);
end component;
begin
	P1: ceas port map(c_set_minut,c_set_ora,c_on_off,c_reset,clock,TC_ceas,ora,minut);
	P2: calendar port map(TC_ceas,reset_calendar,clock,set_zi,set_luna,set_an,an_bisect,an,luna,zi);
	P3: alarma port map(clock,a_on_off,a_reset,a_set_minut,a_set_ora,ora_aux,minut_aux,sonerie,ora_alarma,minut_alarma); 
	P4: det_an_bisect port map(an,an_bisect);
	P5: det_zi_sapt port map(an_aux,luna_aux,zi_aux,zi_sapt_integer);
	P6: temperatura port map(temp);
	ora_aux<=ora;
	minut_aux<=minut; 
	an_aux<=an;
	luna_aux<=luna;
	zi_aux<=zi;	
	temp_out<=temp;
	zi_sapt_string<="DU" when zi_sapt_integer=0 else
"LU" when zi_sapt_integer=1 else
"MA" when zi_sapt_integer=2 else
"MI" when zi_sapt_integer=3 else
"JO" when zi_sapt_integer=4 else
"VI" when zi_sapt_integer=5 else
"SA" when zi_sapt_integer=6;
end arch_agenda;