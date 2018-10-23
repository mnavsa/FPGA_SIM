library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity EDAC_SIM_1 is
port(	CLK 	 	: in std_logic;
		SCRUB_EN 	: in std_logic;
		MESSAGE  	: in std_logic_vector(3 downto 0);
		ADDRESS  	: in std_logic_vector(7 downto 0);
		WRITE_EN 	: in std_logic;
		DATA_OUT 	: out std_logic_vector(3 downto 0);
		ERROR 	 	: out std_logic;
		SLOW_CLK_O  : out std_logic);
end EDAC_SIM_1;

architecture RTL of EDAC_SIM_1 is

component ENCODER is
port(	CLK 		: in std_logic;
		MESSAGE 	: in std_logic_vector(3 downto 0);
		ENCODER_OUT : out std_logic_vector(7 downto 0));
end component;

component CORRUPTOR is
port(	CLK 		 : in std_logic;
		CODEWORD_IN	 : in std_logic_vector(7 downto 0);
		CODEWORD_OUT : out std_logic_vector(7 downto 0));
end component;

component DECODER is
port(	CLK 		 : in std_logic;
		ENABLE		 : in std_logic;
		CODEWORD_IN  : in std_logic_vector(7 downto 0);
		CODEWORD_OUT : out std_logic_vector(7 downto 0);
		DATA_OUT 	 : out std_logic_vector(3 downto 0);
		CORRECTED 	 : out std_logic;
		ERROR 		 : out std_logic);
end component;

component SCRUBBER is
port(	CLK 		 : in std_logic;
		SCRUB_EN 	 : in std_logic;
		CORRECTED 	 : in std_logic;
		ADDRESS_IN 	 : in std_logic_vector(7 downto 0);
		ADDRESS_OUT  : out std_logic_vector(7 downto 0);
		EN_OUT 		 : out std_logic);
end component;

component RAM is
port(	CLK 		: in std_logic;
		ADDRESS 	: in std_logic_vector(7 downto 0);
		WRITE_EN 	: in std_logic;
		DATA_IN 	: in std_logic_vector(7 downto 0);
		DATA_OUT 	: out std_logic_vector(7 downto 0));
end component;

component TRI_STATE_BUFFER is
port(	INPUT 	: in std_logic;
		EN		: in std_logic;
		OUTPUT	: out std_logic);
end component;

component TRI_STATE_BUFFER_4 is
port(	INPUT 	: in std_logic_vector(3 downto 0);
		EN		: in std_logic;
		OUTPUT	: out std_logic_vector(3 downto 0));
end component;

component TRI_STATE_BUFFER_8 is
port(	INPUT 	: in std_logic_vector(7 downto 0);
		EN		: in std_logic;
		OUTPUT	: out std_logic_vector(7 downto 0));
end component;

component SLOW_CLK is
port(	CLK_IN  : in std_logic;
		CLK_OUT : out std_logic);
end component;

component SLOW_CLK_2 is
port(	CLK_IN  : in std_logic;
		CLK_OUT : out std_logic);
end component;

component SLOW_CLK_5 is
port(	CLK_IN  : in std_logic;
		CLK_OUT : out std_logic);
end component;


signal WEN, WEN_NOT 	: std_logic;
signal SC				: std_logic;
signal SC_2 			: std_logic;
signal SC_5 			: std_logic;
signal ENC_OUT 			: std_logic_vector(7 downto 0);
signal COR_OUT			: std_logic_vector(7 downto 0);
signal SCR_COR_IN		: std_logic;
signal SCR_EN_OUT		: std_logic;
signal SCR_ADR_OUT		: std_logic_vector(7 downto 0);
signal DEC_CDW_OUT		: std_logic_vector(7 downto 0);
signal DEC_DAT_OUT		: std_logic_vector(3 downto 0);
signal DEC_COR_OUT		: std_logic;
signal DEC_ERR_OUT		: std_logic;
signal RAM_DAT_IN		: std_logic_vector(7 downto 0);
signal RAM_DAT_OUT		: std_logic_vector(7 downto 0);
signal RAM_ADR_IN		: std_logic_vector(7 downto 0);
signal RAM_WEN_IN		: std_logic;

begin

	block_01 : ENCODER
		port map(CLK,MESSAGE,ENC_OUT);
		
	block_02 : CORRUPTOR
		port map(SC_2,ENC_OUT,COR_OUT);
		
	block_03 : SCRUBBER
		port map(SC,SCRUB_EN,DEC_COR_OUT,ADDRESS,SCR_ADR_OUT,SCR_EN_OUT);
		
	block_04 : DECODER
		port map(CLK,WEN,RAM_DAT_OUT,DEC_CDW_OUT,DEC_DAT_OUT,DEC_COR_OUT,DEC_ERR_OUT);
		
	block_05 : SLOW_CLK
		port map(CLK,SC);
		
	block_06 : RAM
		port map(SC,RAM_ADR_IN,RAM_WEN_IN,RAM_DAT_IN,RAM_DAT_OUT);
		
	block_07 : TRI_STATE_BUFFER --USER WRITE ENABLE
		port map(WEN,WEN,RAM_WEN_IN);
		
	block_08 : TRI_STATE_BUFFER--SCRUBBER WRITE ENABLE
		port map(SCRUB_EN,WEN_NOT,RAM_WEN_IN);
		
	block_09 : TRI_STATE_BUFFER--DECODER ERROR
		port map(DEC_ERR_OUT,SC,ERROR);
		
	block_10 : TRI_STATE_BUFFER--DECODER CORRECTED
		port map(DEC_COR_OUT,SC,SCR_COR_IN);
		
	block_11 : TRI_STATE_BUFFER_4--DECODER DATA_OUT
		port map(DEC_DAT_OUT,SC_5,DATA_OUT);
		
	block_12 : TRI_STATE_BUFFER_8--USER ADDRESS
		port map(ADDRESS,WEN,RAM_ADR_IN);
	
	block_13 : TRI_STATE_BUFFER_8--SCRUBBER ADDRESS
		port map(SCR_ADR_OUT,WEN_NOT,RAM_ADR_IN);
		
	block_14 : TRI_STATE_BUFFER_8--USER CODEWORD
		port map(COR_OUT,WEN,RAM_DAT_IN);
		
	block_15 : TRI_STATE_BUFFER_8--DECODER CODEWORD
		port map(DEC_CDW_OUT,WEN_NOT,RAM_DAT_IN);
		
	block_16 : SLOW_CLK_2
		port map(CLK,SC_2);
		
	block_17 : SLOW_CLK_5
		port map(CLK,SC_5);
		
	WEN <= WRITE_EN;
	WEN_NOT <= NOT WRITE_EN;
	SLOW_CLK_O <= SC;

end RTL;