library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CMP is
port(	DATA_IN_1 : in std_logic_vector(3 downto 0);
		DATA_IN_2 : in std_logic_vector(3 downto 0);
		ENABLE 	  : in std_logic;
		CMP_OUT	  : out std_logic);
end CMP;

architecture RTL of CMP is
begin
	process(DATA_IN_1, DATA_IN_2)
	begin
		if DATA_IN_2 = "ZZZZ" then
			CMP_OUT <= '0';
		elsif DATA_IN_1 = DATA_IN_2 then
			CMP_OUT <= '0';
		else 
			CMP_OUT <= '1';
		end if;
	end process;
	
end RTL;