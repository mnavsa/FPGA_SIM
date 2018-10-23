library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SCRUBBER is
port(	CLK 		 : in std_logic;
		SCRUB_EN 	 : in std_logic;
		CORRECTED 	 : in std_logic;
		ADDRESS_IN 	 : in std_logic_vector(7 downto 0);
		ADDRESS_OUT  : out std_logic_vector(7 downto 0);
		EN_OUT 		 : out std_logic);
end SCRUBBER;

architecture RTL of SCRUBBER is
signal TEMP : std_logic;
begin
	process(CLK,CORRECTED,SCRUB_EN)
	begin
		if SCRUB_EN = '1' then
			if rising_edge(CLK) AND CORRECTED = '1' then
					TEMP <= '1';
			else 
				TEMP <= '0';
			end if;
		end if;
	end process;
	EN_OUT <= TEMP;
	ADDRESS_OUT  <= ADDRESS_IN;
end RTL;