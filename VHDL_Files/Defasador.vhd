library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Defasador is
	port (
			clk1, clk2, clk3, spulso, clkout: out std_logic;
			clk: in std_logic
	);
end Defasador;

architecture Behavioral of Defasador is
	signal ea: std_logic_vector(1 downto 0) := "00";
	signal counter: integer:=1;
begin
	process(clk)
	begin
	if (clk'event and clk='1') then
		if(ea="00") then
			clk1 <= '1';
			clk2 <= '0';
			clk3 <= '0';
			spulso <= '0';
			ea <= "01";
		end if;
		if(ea="01") then
			clk1 <= '0';
			clk2 <= '1';
			clk3 <= '0';
			spulso <= '0';
			ea <= "10";
		end if;
		if(ea="10") then
			clk1 <= '0';
			clk2 <= '0';
			clk3 <= '1';
			spulso <= '0';
			ea <= "11";
		end if;
		if(ea="11") then
			clk1 <= '0';
			clk2 <= '0';
			clk3 <= '0';
			spulso <= '1';
			ea <= "00";
		end if;
	end if;
		
	end process;


end Behavioral;

