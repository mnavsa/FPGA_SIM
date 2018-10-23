library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity DED is
port(	CLK 		 : in std_logic;
		CODEWORD_IN  : in std_logic_vector(7 downto 0);
		CODEWORD_OUT : out std_logic_vector(7 downto 0);
		DATA_OUT 	 : out std_logic_vector(3 downto 0);
		ERROR 		 : out std_logic);
end DED;

architecture RTL of DED is
signal PARITY_CHECK : std_logic;
begin
	PARITY_CHECK <= CODEWORD_IN(6) XOR CODEWORD_IN(5) XOR CODEWORD_IN(4) XOR CODEWORD_IN(3) XOR CODEWORD_IN(2) XOR CODEWORD_IN(1) XOR CODEWORD_IN(0);
	process(CLK,CODEWORD_IN)
	begin
		if rising_edge(CLK) then 
			CODEWORD_OUT <= CODEWORD_IN;
			if PARITY_CHECK = CODEWORD_IN(7) then
				DATA_OUT(0) <= CODEWORD_IN(2);
				DATA_OUT(1) <= CODEWORD_IN(4);
				DATA_OUT(2) <= CODEWORD_IN(5);
				DATA_OUT(3) <= CODEWORD_IN(6);
				ERROR <= '0';
			else
				ERROR <= '1';
				DATA_OUT(0) <= CODEWORD_IN(2);
				DATA_OUT(1) <= CODEWORD_IN(4);
				DATA_OUT(2) <= CODEWORD_IN(5);
				DATA_OUT(3) <= CODEWORD_IN(6);
			end if;
		end if;
	
	end process;
	
end RTL;