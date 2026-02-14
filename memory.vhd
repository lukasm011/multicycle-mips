library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity memory is
generic(depth: integer := 127);
port(a, wd: in STD_LOGIC_VECTOR(31 downto 0);
	clk, we: in STD_LOGIC;
	rd: out STD_LOGIC_VECTOR(31 downto 0));
end;

architecture synth of memory is
type memtype is array(depth downto 0) of STD_LOGIC_VECTOR(31 downto 0);
signal mem: memtype := (0=>"00100001010010010000000000010000",
			9=> "10001100000010010000000000101000",
			10=> "00000000000010000000000000000011",
			others=>X"00000000");
begin
	process(clk, a, mem) begin
		if(rising_edge(clk)) then
			if(we='1') then
				mem(to_integer(unsigned(a(31 downto 2)))) <= wd;
			end if;
		end if;
		rd <= mem(to_integer(unsigned(a(31 downto 2))));
	end process;
end;