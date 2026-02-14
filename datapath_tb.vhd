library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity datapath_tb is
end;

architecture test of datapath_tb is
component datapath
port(clk, pcen, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord, reset : in STD_LOGIC;
	pcsrc: in STD_LOGIC_VECTOR(1 downto 0);
	alusrcb: in STD_LOGIC_VECTOR(1 downto 0);
	alucontrol: in STD_LOGIC_VECTOR(2 downto 0);
	memorya: out STD_LOGIC_VECTOR(31 downto 0);
	memoryrd: in STD_LOGIC_VECTOR(31 downto 0);
	memorywd: out STD_LOGIC_VECTOR(31 downto 0);
	zero: out STD_LOGIC;
	instruction: out STD_LOGIC_VECTOR(31 downto 0));
end component;
component controller
port(pcen, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord : out STD_LOGIC;
	pcsrc: out STD_LOGIC_VECTOR(1 downto 0);
	alusrcb: out STD_LOGIC_VECTOR(1 downto 0);
	alucontrol: out STD_LOGIC_VECTOR(2 downto 0);
	zero: in STD_LOGIC;
	clk, reset: in STD_LOGIC;
	instruct : in STD_LOGIC_VECTOR(31 downto 0));
end component;
component memory
port(a, wd: in STD_LOGIC_VECTOR(31 downto 0);
	clk, we: in STD_LOGIC;
	rd: out STD_LOGIC_VECTOR(31 downto 0));
end component;
signal pcen, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord : STD_LOGIC;
signal pcsrc: STD_LOGIC_VECTOR(1 downto 0);
signal zero, clk, reset, we : STD_LOGIC;
signal alusrcb: STD_LOGIC_VECTOR(1 downto 0);
signal alucontrol: STD_LOGIC_VECTOR(2 downto 0);
signal instruct: STD_LOGIC_VECTOR(31 downto 0);
signal memorya, memoryrd, memorywd : STD_LOGIC_VECTOR(31 downto 0); 
begin
dut: datapath port map(clk, pcen, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord, reset, pcsrc, alusrcb, alucontrol,
			memorya, memoryrd, memorywd, zero, instruct);
cont: controller port map(pcen, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord, pcsrc, alusrcb, alucontrol, zero,
			clk, reset, instruct);
mem: memory port map(memorya, memorywd, clk, memwrite, memoryrd);
clk_proc: process
	begin
  		while true loop
   			clk <= '0';
			wait for 5 ps;
    			clk <= '1';
    			wait for 5 ps;
  		end loop;
	end process;
	process begin
		reset <= '1';
		wait for 6ps;
		reset <= '0';
		wait;
	end process;
end;
