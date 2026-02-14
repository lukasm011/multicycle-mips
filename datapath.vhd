library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity datapath is
port(clk, pcen, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord, reset : in STD_LOGIC;
	pcsrc: in STD_LOGIC_VECTOR(1 downto 0);
	alusrcb: in STD_LOGIC_VECTOR(1 downto 0);
	alucontrol: in STD_LOGIC_VECTOR(2 downto 0);
	memorya: out STD_LOGIC_VECTOR(31 downto 0);
	memoryrd: in STD_LOGIC_VECTOR(31 downto 0);
	memorywd: out STD_LOGIC_VECTOR(31 downto 0);
	zero: out STD_LOGIC;
	instruction: out STD_LOGIC_VECTOR(31 downto 0));
end;
architecture struct of datapath is
component sl2
generic(n: integer := 31);
port(a: in STD_LOGIC_VECTOR(n downto 0);
	y: out STD_LOGIC_VECTOR(n downto 0));
end component;
component signextender
port(a: in STD_LOGIC_VECTOR(15 downto 0);
	y: out STD_LOGIC_VECTOR(31 downto 0));
end component;
component regfile
port(clk, we3: in STD_LOGIC;
	a1, a2, a3: in STD_LOGIC_VECTOR(4 downto 0);
	rd1, rd2: out STD_LOGIC_VECTOR(31 downto 0);
	wd3: in STD_LOGIC_VECTOR);
end component;
component mux4
port(a0, a1, a2, a3: in STD_LOGIC_VECTOR(31 downto 0);
	y: out STD_LOGIC_VECTOR(31 downto 0);
	s: in STD_LOGIC_VECTOR(1 downto 0));
end component;
component mux2
generic(n: integer:=32);
port(a0, a1: in STD_LOGIC_VECTOR(n-1 downto 0);
	y: out STD_LOGIC_VECTOR(n-1 downto 0);
	s: in STD_LOGIC);
end component;
component flopr
port(d: in STD_LOGIC_VECTOR(31 downto 0);
	q: out STD_LOGIC_VECTOR(31 downto 0);
	en, clk, reset: in STD_LOGIC);
end component;
component alu
port(srca, srcb: in STD_LOGIC_VECTOR(31 downto 0);
	alucontrol: in STD_LOGIC_VECTOR(2 downto 0);
	aluresult: buffer STD_LOGIC_VECTOR(31 downto 0);
	zero: out STD_LOGIC);
end component;
component slad
generic(n: integer :=25);
port(a: in STD_LOGIC_VECTOR(n downto 0);
	y: out STD_LOGIC_VECTOR(n+2 downto 0));
end component;
--signal declaration
signal memrd: STD_LOGIC_VECTOR(31 downto 0);
signal instruct: STD_LOGIC_VECTOR(31 downto 0);
signal data: STD_LOGIC_VECTOR(31 downto 0);
signal a3: STD_LOGIC_VECTOR(4 downto 0);
signal aluout: STD_LOGIC_VECTOR(31 downto 0);
signal wd3: STD_LOGIC_VECTOR(31 downto 0);
signal rd1, rd2: STD_LOGIC_VECTOR(31 downto 0);
signal a, b: STD_LOGIC_VECTOR(31 downto 0);
signal pcnext, pc: STD_LOGIC_VECTOR(31 downto 0);
signal srca, srcb: STD_LOGIC_VECTOR(31 downto 0);
signal signimm, signimmsh: STD_LOGIC_VECTOR(31 downto 0);
signal aluresult: STD_LOGIC_VECTOR(31 downto 0);
signal js2: STD_LOGIC_VECTOR(31 downto 0);
begin
rf : regfile port map(clk, regwrite, instruct(25 downto 21), instruct(20 downto 16), a3, rd1, rd2, wd3);
pcreg: flopr port map(pcnext, pc, pcen, clk, reset);
instreg: flopr port map(memoryrd, instruct, irwrite, clk, reset);
datareg: flopr port map(memoryrd, data, '1', clk, reset);
a3mux: mux2 generic map(5) port map(instruct(20 downto 16), instruct(15 downto 11), a3, regdst);
wd3mux: mux2 generic map(32) port map(aluout, data, wd3, memtoreg);
areg: flopr port map(rd1, a, '1', clk, reset);
breg: flopr port map(rd2, b, '1', clk, reset);
srcamux: mux2 generic map(32) port map(pc, a, srca, alusrca);
srcbmux: mux4 port map(b, X"00000004", signimm, signimmsh, srcb, alusrcb);
alu32: alu port map(srca, srcb, alucontrol, aluresult, zero);
se: signextender port map(instruct(15 downto 0), signimm);
shifter: sl2 port map(signimm, signimmsh);
shifter25: slad generic map(25) port map(instruct(25 downto 0), js2(27 downto 0));
alureg: flopr port map(aluresult, aluout, '1', clk, reset);
outmux: mux4 port map(aluresult, aluout, js2, X"00000000", pcnext, pcsrc);
memoryamux: mux2 port map(pc, aluout, memorya, iord);
memorywd <= b;
instruction <= instruct;
js2(31 downto 28) <= pc(31 downto 28);
end;