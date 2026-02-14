library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity flopr is
port(d: in STD_LOGIC_VECTOR(31 downto 0);
	q: out STD_LOGIC_VECTOR(31 downto 0);
	en, clk, reset: in STD_LOGIC);
end;
architecture synth of flopr is

begin
	process(clk) begin
		if(rising_edge(clk)) then
			if(reset='1') then
			q<=(others=>'0');
			else
			if(en='1') then
			q<=d;
			end if;
			end if;
		end if;
	end process;
end;
