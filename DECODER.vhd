library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity DECODER is
port(	CLK 		 : in std_logic;
		ENABLE		 : in std_logic;
		CODEWORD_IN  : in std_logic_vector(7 downto 0);
		CODEWORD_OUT : out std_logic_vector(7 downto 0);
		DATA_OUT 	 : out std_logic_vector(3 downto 0);
		CORRECTED 	 : out std_logic;
		ERROR 		 : out std_logic);
end DECODER;

architecture RTL of DECODER is
component SED is
port(	CLK 		 : in std_logic;
		CODEWORD_IN  : in std_logic_vector(7 downto 0);
		CODEWORD_OUT : out std_logic_vector(7 downto 0);
		PARITY_OUT 	 : out std_logic_vector(2 downto 0));
end component;
component SEC is
port( 	CLK 			: in std_logic;
		PARITY_IN 		: in std_logic_vector(2 downto 0);
		CODEWORD_IN 	: in std_logic_vector(7 downto 0);
		CODEWORD_OUT 	: out std_logic_vector(7 downto 0);
		CORRECTED 		: out std_logic);
end component;
component DED is
port(	CLK 		 : in std_logic;
		CODEWORD_IN  : in std_logic_vector(7 downto 0);
		CODEWORD_OUT : out std_logic_vector(7 downto 0);
		DATA_OUT 	 : out std_logic_vector(3 downto 0);
		ERROR 		 : out std_logic);
end component;
signal SED_OUT_1 		: std_logic_vector(7 downto 0);
signal SED_OUT_2		: std_logic_vector(2 downto 0);
signal SEC_OUT_1 		: std_logic_vector(7 downto 0);
signal DATA		 		: std_logic_vector(3 downto 0);
signal t_CORRECT		: std_logic;
signal t_ERROR   		: std_logic;
signal t_CODEWORD_OUT 	: std_logic_vector(7 downto 0);
begin
	block_1 : SED
		port map(CLK,CODEWORD_IN,SED_OUT_1,SED_OUT_2);
	block_2 : SEC
		port map(CLK,SED_OUT_2,SED_OUT_1,SEC_OUT_1,t_CORRECT);
	block_3 : DED
		port map(CLK,SEC_OUT_1,t_CODEWORD_OUT,DATA,t_ERROR);
	DATA_OUT <= DATA when ENABLE = '0' else "ZZZZ";
	CORRECTED <= t_CORRECT when ENABLE = '0' else 'Z';
	ERROR <= t_ERROR when ENABLE = '0' else 'Z';
	CODEWORD_OUT <= t_CODEWORD_OUT when ENABLE = '0' else "ZZZZZZZZ";
end RTL;