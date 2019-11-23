library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DISP is
  Port ( q0: in STD_LOGIC_VECTOR (3 downto 0);
         q1: in STD_LOGIC_VECTOR (3 downto 0);
         q2: in STD_LOGIC_VECTOR (3 downto 0);
         q3: in STD_LOGIC_VECTOR (3 downto 0);
         seg: out STD_LOGIC_VECTOR (6 downto 0);
         an: out STD_LOGIC_VECTOR (3 downto 0);
         clk: in STD_LOGIC);
end DISP;

architecture Behavioral of DISP is
    signal e: STD_LOGIC_VECTOR (1 downto 0);
begin
    Demux_inst: entity work.Demux
    port map (
        e => e,
        q0 => q0,
        q1 => q1,
        q2 => q2,
        q3 => q3,
        seg => seg
    );
    
    Decod_inst: entity work.Decod
    port map (
        an => an,
        e => e
    );
    
    Cont_inst: entity work.Contador
    port map (
        clk => clk,
        e => e
    );

end Behavioral;
