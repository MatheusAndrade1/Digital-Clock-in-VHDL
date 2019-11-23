library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity ajuste_alarme is
port (
  clk    : in std_logic;
  enablem: in std_logic;
  enableh: in std_logic;
  clear: in std_logic;
  hdl,hul,mdl,mul: in integer range 0 to 9:=0;
  n0,n1,n2,n3: out integer range 0 to 9:=0
);
end ajuste_alarme;
 
architecture Behavioral of ajuste_alarme is
begin 

  process(clk) 
  begin
    if(clk'event and clk='1') then
			if(enablem='1')then
			  if (mdl=5 and mul=9) then
					n2 <= 0;
					n3 <= 0;
			  else
					if (mul<9) then
						 n3 <= mul+1;
					else
						 n3 <= 0;
						if (mdl<5) then
							n2 <= mdl+1;
						else
							n2 <= 0;
						end if;
					end if;
				end if;
			end if;
		
			if(enableh='1')then
				if (hdl=2 and hul=3) then
						n0 <= 0;
						n1 <= 0;
				else
					if (hul<9 and hdl < 2) then
						n1 <= hul+1;
					elsif (hdl = 2 and hul<3) then
						n1 <= hul+1;
					else
						n1 <= 0;
						
						if (hdl<2) then
							n0 <= hdl+1;
						else
							n0 <= 0;
						end if;
					end if;
				end if;
			end if;		  
	end if;
	
	
	if(clear='0')then
			n0 <= 0;
			n1 <= 0;
			n2 <= 0;
			n3 <= 0;
	end if;
  end process;  
end Behavioral;