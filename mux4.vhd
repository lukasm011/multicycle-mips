library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity mux4 is
port(a0, a1, a2, a3: in STD_LOGIC_VECTOR(31 downto 0);
	y: out STD_LOGIC_VECTOR(31 downto 0);
	s: in STD_LOGIC_VECTOR(1 downto 0));
end;

architecture synth of mux4 is

begin
process(a0, a1, a2, a3, s) begin
	case(s) is
		when "00" => y <= a0;
		when "01" => y <= a1;
		when "10" => y <= a2;
		when "11" => y <= a3;
		when others => y <= (others=>'-');
	end case;
end process;
end;