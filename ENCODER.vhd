library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ENCODER is
port(	CLK 		: in std_logic;
		MESSAGE 	: in std_logic_vector(3 downto 0);
		ENCODER_OUT : out std_logic_vector(7 downto 0));
end ENCODER;

architecture RTL of ENCODER is
signal TEMP : std_logic_vector(6 downto 0);
begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			TEMP(0) <= MESSAGE(0) XOR MESSAGE(1) XOR MESSAGE(3);
			TEMP(1) <= MESSAGE(0) XOR MESSAGE(2) XOR MESSAGE(3);
			TEMP(2) <= MESSAGE(0);
			TEMP(3) <= MESSAGE(1) XOR MESSAGE(2) XOR MESSAGE(3);
			TEMP(4) <= MESSAGE(1);
			TEMP(5) <= MESSAGE(2);
			TEMP(6) <= MESSAGE(3);
		end if;
	end process;
	ENCODER_OUT(0) <= TEMP(0);
	ENCODER_OUT(1) <= TEMP(1);
	ENCODER_OUT(2) <= TEMP(2);
	ENCODER_OUT(3) <= TEMP(3);
	ENCODER_OUT(4) <= TEMP(4);
	ENCODER_OUT(5) <= TEMP(5);
	ENCODER_OUT(6) <= TEMP(6);
	ENCODER_OUT(7) <= TEMP(6) XOR TEMP(5) XOR TEMP(4) XOR TEMP(3) XOR TEMP(2) XOR TEMP(1) XOR TEMP(0);
end RTL; 