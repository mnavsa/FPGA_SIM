library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SED is
port(	CLK 		 : in std_logic;
		CODEWORD_IN  : in std_logic_vector(7 downto 0);
		CODEWORD_OUT : out std_logic_vector(7 downto 0);
		PARITY_OUT 	 : out std_logic_vector(2 downto 0));
end SED;

architecture RTL of SED is
begin
	process(CLK,CODEWORD_IN)
	begin
		if rising_edge(CLK) then 
			CODEWORD_OUT <= CODEWORD_IN;
			PARITY_OUT(0) <= CODEWORD_IN(0) xor CODEWORD_IN(2) xor CODEWORD_IN(4) xor CODEWORD_IN(6);
			PARITY_OUT(1) <= CODEWORD_IN(1) xor CODEWORD_IN(2) xor CODEWORD_IN(5) xor CODEWORD_IN(6);
			PARITY_OUT(2) <= CODEWORD_IN(3) xor CODEWORD_IN(4) xor CODEWORD_IN(5) xor CODEWORD_IN(6);
		end if; 		
	end process;
	
end RTL;