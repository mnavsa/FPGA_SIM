library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CORRUPTOR is
port(	CLK 		 : in std_logic;
		CODEWORD_IN	 : in std_logic_vector(7 downto 0);
		CODEWORD_OUT : out std_logic_vector(7 downto 0));
end CORRUPTOR;

architecture RTL of CORRUPTOR is
begin
	process(CLK)
	begin
		if rising_edge(CLK) then 
			CODEWORD_OUT <= CODEWORD_IN XOR "00010000";
		end if;
	end process;
end RTL;