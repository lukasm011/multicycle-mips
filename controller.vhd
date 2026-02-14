library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity controller is
port(pcen, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord : out STD_LOGIC;
	pcsrc: out STD_LOGIC_VECTOR(1 downto 0);
	alusrcb: out STD_LOGIC_VECTOR(1 downto 0);
	alucontrol: out STD_LOGIC_VECTOR(2 downto 0);
	zero: in STD_LOGIC;
	clk, reset: in STD_LOGIC;
	instruct : in STD_LOGIC_VECTOR(31 downto 0));
end;

architecture struct of controller is
component aludec
port(aluop: in STD_LOGIC_VECTOR(1 downto 0);
	funct: in STD_LOGIC_VECTOR(5 downto 0);
	alucontrol: out STD_LOGIC_VECTOR(2 downto 0));
end component;
component maindec
port(pcwrite, branch, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord : out STD_LOGIC;
	pcsrc: out STD_LOGIC_VECTOR(1 downto 0);
	alusrcb: out STD_LOGIC_VECTOR(1 downto 0);
	op : in STD_LOGIC_VECTOR(5 downto 0);
	aluop: out STD_LOGIC_VECTOR(1 downto 0);
	clk, reset: in STD_LOGIC);
end component;
signal op, funct: STD_LOGIC_VECTOR(5 downto 0);
signal aluop: STD_LOGIC_VECTOR(1 downto 0);
signal branch, pcwrite: STD_LOGIC;
begin
op <= instruct(31 downto 26);
funct <= instruct(5 downto 0);
adec: aludec port map(aluop, funct, alucontrol);
mdec: maindec port map(pcwrite, branch, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord, pcsrc, alusrcb,
			op, aluop, clk, reset);
pcen <= pcwrite or (branch and zero);
end;