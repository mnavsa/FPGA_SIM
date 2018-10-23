library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity RAM is
port(	CLK 		: in std_logic;
		ADDRESS 	: in std_logic_vector(7 downto 0);
		WRITE_EN 	: in std_logic;
		DATA_IN 	: in std_logic_vector(7 downto 0);
		DATA_OUT 	: out std_logic_vector(7 downto 0));
end RAM;

architecture RTL of RAM is
type ram_type is array(255 downto 0) of std_logic_vector(7 downto 0);
signal MEMORY : ram_type;
begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			if WRITE_EN = '1' then
				MEMORY(conv_integer(ADDRESS)) <= DATA_IN;
			end if;
		end if;
	end process;
	DATA_OUT <= MEMORY(conv_integer(ADDRESS));
end RTL;