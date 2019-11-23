library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Contador is
  Port (clk: in std_logic;
        e: out std_logic_vector(1 downto 0):="00"
        );
end Contador;

architecture Behavioral of Contador is
    signal ee: std_logic_vector(1 downto 0):="00";
    signal num: integer range 0 to 99999:=0;
    signal clk2: std_logic:='0';
begin

    process(clk)
    begin
        if (clk'event and clk='1') then
            num <= num-1;
                if (num <= 0) then
                    num <= 99999;
                    clk2 <= not(clk2);
                end if;
        end if;
    end process;
    
    process(clk2)
        begin
            if (clk2'event and clk2='1') then
                case ee is
                    when "00" => ee <= "01";
                    when "01" => ee <= "10";
                    when "10" => ee <= "11";
                    when "11" => ee <= "00";
                    when others => ee <= "00";
                end case;
            end if;
        end process;
    e <= ee;

end Behavioral;
