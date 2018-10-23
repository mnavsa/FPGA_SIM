library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity TRI_STATE_BUFFER_8 is
port(	INPUT 	: in std_logic_vector(7 downto 0);
		EN		: in std_logic;
		OUTPUT	: out std_logic_vector(7 downto 0));
end TRI_STATE_BUFFER_8;

architecture RTL of TRI_STATE_BUFFER_8 is
begin
	OUTPUT <= INPUT when (EN = '1') else "ZZZZZZZZ";
end RTL;
