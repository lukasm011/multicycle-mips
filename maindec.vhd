library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity maindec is
port(pcwrite, branch, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord : out STD_LOGIC;
	pcsrc: out STD_LOGIC_VECTOR(1 downto 0);
	alusrcb: out STD_LOGIC_VECTOR(1 downto 0);
	op : in STD_LOGIC_VECTOR(5 downto 0);
	aluop: out STD_LOGIC_VECTOR(1 downto 0);
	clk, reset: in STD_LOGIC);
end;

architecture synth of maindec is
type statetype is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11);
signal state: statetype;
signal nextstate: statetype;
signal controls: STD_LOGIC_VECTOR(14 downto 0);
begin
(branch, pcwrite, alusrca, regwrite, memtoreg, regdst, irwrite, memwrite, iord, pcsrc(1), pcsrc(0), alusrcb(1),alusrcb(0),aluop(1),aluop(0)) <= controls;
process(clk, state) begin
	if(rising_edge(clk)) then
		if(reset='1') then
			state <= s0;
		else
		state <= nextstate;
		end if;
	end if;
	case state is
			when s0 => nextstate <= s1;
				controls <= "010000100000100";
			when s1 => case op is
					when "100011" | "101011" => nextstate <= s2;
					when "000000" => nextstate <= s6;
					when "000100" => nextstate <= s8;
					when "000010" => nextstate <= s9;
					when "001000" => nextstate <= s10;
					when others => nextstate <= s0;
				end case;
			        controls <= "000000000001100";
			when s2 => case op is 
					when "100011" => nextstate <= s3;
					when "101011" => nextstate <= s5;
					when others => nextstate <= s0;
				end case;
				controls <= "001000000001000";
			when s3 => nextstate <= s4;
				controls <= "000000001000000";
			when s4 => nextstate <= s0;
				controls <= "000110000000000";
			when s5 => nextstate <= s0;
				controls <= "000000011000000";
			when s6 => nextstate <= s7;
				controls <= "001000000000010";
			when s7 => nextstate <= s0;
				controls <= "000101000000000";
			when s8 => nextstate <= s0;
				controls <= "101000000010001";
			when s9 => nextstate <= s0;
				controls <= "010000000100000";
			when s10 => nextstate <= s11;
				controls <= "001000000001000";			
			when s11 => nextstate <= s0;
				controls <= "000100000000000";			
			when others => nextstate <= s0;
		end case;
end process;
end;