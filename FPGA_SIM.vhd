library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity FPGA_SIM is
port(	CLK 	: in std_logic;
		CMP_OUT : out std_logic);
end FPGA_SIM;

architecture RTL of FPGA_SIM is

component EDAC_SIM_1 is
port(	CLK 	 	: in std_logic;
		SCRUB_EN 	: in std_logic;
		MESSAGE  	: in std_logic_vector(3 downto 0);
		ADDRESS  	: in std_logic_vector(7 downto 0);
		WRITE_EN 	: in std_logic;
		DATA_OUT 	: out std_logic_vector(3 downto 0);
		ERROR 	 	: out std_logic;
		SLOW_CLK_O  : out std_logic);
end component;

component ADDR_GEN is
port(	CLK 	: in std_logic;
		ADDR_O  : out std_logic_vector(7 downto 0));
end component;

component MSG_GEN is
port(	CLK		: in std_logic;
		MSG_O	: out std_logic_vector(3 downto 0));
end component;

component SLOW_CLK_3 is
port(	CLK_IN : in std_logic;
		CLK_OUT : out std_logic);
end component;

component SLOW_CLK_4 is
port(	CLK_IN  : in std_logic;
		CLK_OUT : out std_logic);
end component;

component SLOW_CLK_5 is
port(	CLK_IN  : in std_logic;
		CLK_OUT : out std_logic);
end component;

component CMP is
port(	DATA_IN_1 : in std_logic_vector(3 downto 0);
		DATA_IN_2 : in std_logic_vector(3 downto 0);
		ENABLE 	  : in std_logic;
		CMP_OUT	  : out std_logic);
end component;

signal SC3 : std_logic;
signal SC4 : std_logic;
signal SC5 : std_logic;
signal SC : std_logic;
signal EN : std_logic := '1';
signal MSG_IN : std_logic_vector(3 downto 0);
signal ADR_IN : std_logic_vector(7 downto 0);
signal DAT_OUT :  std_logic_vector(3 downto 0);
signal ERR : std_logic;


begin

	block_01 : EDAC_SIM_1
		port map(CLK,EN,MSG_IN,ADR_IN,SC4,DAT_OUT,ERR,SC);
		
	block_02 : ADDR_GEN
		port map(SC3,ADR_IN);
		
	block_03 : MSG_GEN
		port map(SC3,MSG_IN);
		
	block_04: SLOW_CLK_3
		port map(CLK,SC3);
		
	block_05: CMP
		port map(MSG_IN,DAT_OUT,SC5,CMP_OUT);
		
	block_06 : SLOW_CLK_4
		port map(CLK,SC4);
		
	block_07 : SLOW_CLK_5
		port map(CLK,SC5);
end RTL;