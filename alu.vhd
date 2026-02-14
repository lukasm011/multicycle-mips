library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.NUMERIC_STD.all;

entity alu is
port(srca, srcb: in STD_LOGIC_VECTOR(31 downto 0);
	alucontrol: in STD_LOGIC_VECTOR(2 downto 0);
	aluresult: buffer STD_LOGIC_VECTOR(31 downto 0);
	zero: out STD_LOGIC);
end;

architecture synth of alu is
begin
process(srca, srcb, alucontrol, aluresult) begin
	case alucontrol is
		when "000" => aluresult <= srca and srcb;
		when "001" => aluresult <= srca or srcb;
		when "010" => aluresult <= std_logic_vector(unsigned(srca) + unsigned(srcb));
		when "011" => aluresult <= (others => '-');
		when "100" => aluresult <= srca and (not srcb);
		when "101" => aluresult <= srca or (not srcb);
		when "110" => aluresult <= std_logic_vector(unsigned(srca) - unsigned(srcb));
		when "111" => if(srca<srcb) then
				aluresult <= X"00000001";
			      else 
				aluresult <= (others=>'0');
				end if;
		when others => aluresult <= (others=>'0');
	end case;
	case aluresult is 
		when x"00000000" => zero <= '1';
		when others => zero <= '0';
	end case;
end process;
end;