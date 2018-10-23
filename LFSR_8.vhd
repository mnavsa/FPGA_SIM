library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity LFSR_8 is
port(	CLK		 : in std_logic;
		LFSR_OUT : out std_logic_vector(7 downto 0));
end LFSR_8;

architecture RTL of LFSR_8 is
signal XNOR_OUT : std_logic := '0';
signal DATA_OUT : std_logic_vector(7 downto 0) := "00000000";
begin
	process(CLK)
	variable registers : std_logic_vector(7 downto 0):= (others => '0');
	begin
		LFSR_OUT <= DATA_OUT;
		if rising_edge(CLK) then
			XNOR_OUT 	 <= registers(7) XNOR registers(5) XNOR registers(4) XNOR registers(3) ;
			registers(7) := registers(6);
			registers(6) := registers(5);
			registers(5) := registers(4);
			registers(4) := registers(3);
			registers(3) := registers(2);
			registers(2) := registers(1);
			registers(1) := registers(0);
			registers(0) := XNOR_OUT;
			DATA_OUT 	 <= registers;
		end if;
	end process;
end RTL;