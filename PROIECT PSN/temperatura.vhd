library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.all;

entity temperatura is
	port(t: out integer);
end temperatura;

architecture arch_temperatura of temperatura is
begin
	process
	variable seed1,seed2: positive;
	variable rand: real;
	variable range_of_rand: real:=45.0;
	begin
		uniform(seed1,seed2,rand);
		t<=integer(rand*range_of_rand);
		wait for 10 ns;
	end process;
end architecture;