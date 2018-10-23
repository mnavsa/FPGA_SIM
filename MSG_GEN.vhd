library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MSG_GEN is
port(	CLK		: in std_logic;
		MSG_O	: out std_logic_vector(3 downto 0));
end MSG_GEN;

architecture RTL of MSG_GEN is
signal TEMP : std_logic_vector(3 downto 0) := "0000";
begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			if TEMP = "1111" then
				TEMP <= "0000";
			else
				TEMP <= TEMP + "0001";
			end if;
		end if;
	end process;
	MSG_O <= TEMP;
end RTL;