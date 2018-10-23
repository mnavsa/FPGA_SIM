library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SLOW_CLK_4 is
port(	CLK_IN  : in std_logic;
		CLK_OUT : out std_logic);
end SLOW_CLK_4;

architecture RTL of SLOW_CLK_4 is
signal TEMP 	 : std_logic_vector(3 downto 0) := "0000";
signal T_CLK_OUT : std_logic := '1';
begin
	process(CLK_IN) 
	begin
		if CLK_IN'event AND rising_edge(CLK_IN) then
			if TEMP = "0101" then
				T_CLK_OUT <= '1';
				TEMP <= "0000";
			elsif TEMP = "000" OR TEMP = "001" then
				T_CLK_OUT <= '1';
				TEMP <= TEMP + "0001";
			else
				T_CLK_OUT <= '0';
				TEMP <= TEMP + "0001";
			end if;
		end if;
	end process;
	CLK_OUT <= T_CLK_OUT;
end RTL;
