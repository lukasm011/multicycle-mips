library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity signextender is
port(a: in STD_LOGIC_VECTOR(15 downto 0);
	y: out STD_LOGIC_VECTOR(31 downto 0));
end;

architecture synth of signextender is
begin
	y<=x"FFFF"&a when a(15)='1' else x"0000"&a;
end;