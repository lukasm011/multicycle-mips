library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD;

entity slad is
generic(n: integer := 25);
port(a: in STD_LOGIC_VECTOR(n downto 0);
	y: out STD_LOGIC_VECTOR(n+2 downto 0));
end;

architecture synth of slad is
begin
	y<=a(n downto 0)&"00";
end;