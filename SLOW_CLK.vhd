library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SLOW_CLK is
port(	CLK_IN  : in std_logic;
		CLK_OUT : out std_logic);
end SLOW_CLK;

architecture RTL of SLOW_CLK is
signal TEMP 	 : std_logic_vector(3 downto 0) := "0001";
signal T_CLK_OUT : std_logic := '0';
begin
	process(CLK_IN) 
	begin
		if CLK_IN'event then
			if TEMP = "0101" then
				T_CLK_OUT <= '1';
				TEMP <= "0000";
			else
				T_CLK_OUT <= '0';
				TEMP <= TEMP + "0001";
			end if;
		end if;
	end process;
	CLK_OUT <= T_CLK_OUT;
end RTL;

