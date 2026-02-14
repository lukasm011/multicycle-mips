library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity aludec is
port(aluop: in STD_LOGIC_VECTOR(1 downto 0);
	funct: in STD_LOGIC_VECTOR(5 downto 0);
	alucontrol: out STD_LOGIC_VECTOR(2 downto 0));
end;

architecture synth of aludec is

begin
	process(aluop, funct) begin
		case aluop is
			when "00" => alucontrol <= "010";
			when "01" => alucontrol <= "110";
			when "10" => case funct is
					when "100000" => alucontrol <= "010";
					when "100010" => alucontrol <= "110";
					when "100100" => alucontrol <= "000";
					when "100101" => alucontrol <= "001";
					when "101010" => alucontrol <= "111";
					when others => alucontrol <= "---";
			end case;
			when others => alucontrol <= "---";
		end case;
	end process;

end;