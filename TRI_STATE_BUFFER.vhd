library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity TRI_STATE_BUFFER is
port(	INPUT 	: in std_logic;
		EN		: in std_logic;
		OUTPUT	: out std_logic);
end TRI_STATE_BUFFER;

architecture RTL of TRI_STATE_BUFFER is
begin
	OUTPUT <= INPUT when (EN = '1') else 'Z';
end RTL;