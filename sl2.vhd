library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD;

entity sl2 is
generic(n: integer := 31);
port(a: in STD_LOGIC_VECTOR(n downto 0);
	y: out STD_LOGIC_VECTOR(n downto 0));
end;

architecture synth of sl2 is
begin
	y<=a(n-2 downto 0)&"00";
end;