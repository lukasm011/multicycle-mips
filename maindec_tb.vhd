library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity maindec_tb is
end;

architecture test of maindec_tb is
signal pcen, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord, pcsrc : STD_LOGIC;
signal alusrcb: STD_LOGIC_VECTOR(1 downto 0);
signal op : STD_LOGIC_VECTOR(5 downto 0);
signal aluop: STD_LOGIC_VECTOR(1 downto 0);
signal clk, reset: STD_LOGIC;
component maindec is
port(pcen, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord, pcsrc : out STD_LOGIC;
	alusrcb: out STD_LOGIC_VECTOR(1 downto 0);
	op : in STD_LOGIC_VECTOR(5 downto 0);
	aluop: out STD_LOGIC_VECTOR(1 downto 0);
	clk, reset: in STD_LOGIC);
end component;
begin
dut: maindec port map(pcen, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord, pcsrc,
	alusrcb, op, aluop, clk, reset);
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
		op<="000100";		
		wait;
	end process;
end; 