library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity controller_tb is
end;

architecture test of controller_tb is
component controller
port(pcen, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord, pcsrc : out STD_LOGIC;
	alusrcb: out STD_LOGIC_VECTOR(1 downto 0);
	alucontrol: out STD_LOGIC_VECTOR(2 downto 0);
	zero: in STD_LOGIC;
	clk, reset: in STD_LOGIC;
	instruct : in STD_LOGIC_VECTOR(31 downto 0));
end component;
signal pcen, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord, pcsrc : STD_LOGIC;
signal zero, clk, reset : STD_LOGIC;
signal alusrcb: STD_LOGIC_VECTOR(1 downto 0);
signal alucontrol: STD_LOGIC_VECTOR(2 downto 0);
signal instruct: STD_LOGIC_VECTOR(31 downto 0);
begin
dut: controller port map(pcen, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord, pcsrc,
	alusrcb,
	alucontrol,
	zero,
	clk, reset,
	instruct);
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
	process begin
		instruct<="00010001001010100000000010011000";		
		wait;
	end process;

end;