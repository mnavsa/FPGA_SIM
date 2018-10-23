library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity LFSR_4 is
port(	CLK		 : in std_logic;
		LFSR_OUT : out std_logic_vector(3 downto 0));
end LFSR_4;

architecture RTL of LFSR_4 is
signal XNOR_OUT : std_logic := '0';
signal DATA_OUT : std_logic_vector(3 downto 0) := "0000";
begin
	process(CLK)
	variable registers : std_logic_vector(3 downto 0):= (others => '0');
	begin
		LFSR_OUT <= DATA_OUT;
		if rising_edge(CLK) then
			XNOR_OUT 	 <= registers(3) xnor registers(2);
			registers(3) := registers(2);
			registers(2) := registers(1);
			registers(1) := registers(0);
			registers(0) := XNOR_OUT;
			DATA_OUT 	 <= registers;
		end if;
	end process;
end RTL;