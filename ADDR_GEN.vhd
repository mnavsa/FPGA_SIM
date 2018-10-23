library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ADDR_GEN is
port(	CLK 	: in std_logic;
		ADDR_O  : out std_logic_vector(7 downto 0));
end ADDR_GEN;

architecture RTL of ADDR_GEN is
signal TEMP : std_logic_vector(7 downto 0) := "00000000";
begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			if TEMP = "11111111" then
				TEMP <= "00000000";
			else
				TEMP <= TEMP + "00000001";
			end if;
		end if;
	end process;
	ADDR_O <= TEMP;
end RTL;