library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity mux2 is
generic(n: integer:=32);
port(a0, a1: in STD_LOGIC_VECTOR(n-1 downto 0);
	y: out STD_LOGIC_VECTOR(n-1 downto 0);
	s: in STD_LOGIC);
end entity mux2;
architecture synth of mux2 is
begin
y<=a0 when s='0' else a1;
end;