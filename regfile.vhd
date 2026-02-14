library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity regfile is
port(clk, we3: in STD_LOGIC;
	a1, a2, a3: in STD_LOGIC_VECTOR(4 downto 0);
	rd1, rd2: out STD_LOGIC_VECTOR(31 downto 0);
	wd3: in STD_LOGIC_VECTOR);
end entity;
architecture synth of regfile is
type memtype is array(31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
signal mem: memtype := (9=>X"00000001",
			10=>X"00000002",
			others=>X"00000000");
begin
	process(clk, a1, a2, mem) begin
		if(rising_edge(clk)) then
			if(we3='1' and a3 /= "00000") then
				mem(to_integer(unsigned(a3)))<=wd3;
			end if;
		end if;
		rd1<=mem(to_integer(unsigned(a1)));
		rd2<=mem(to_integer(unsigned(a2)));
	end process;
end;