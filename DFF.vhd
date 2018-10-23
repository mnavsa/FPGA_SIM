library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity DFF is
port(	CLK	: in std_logic;
		D	: in std_logic;
		Q	: out std_logic);
end DFF;

architecture RTL of DFF is
begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			Q <= D;
		end if;
	end process;
end RTL;