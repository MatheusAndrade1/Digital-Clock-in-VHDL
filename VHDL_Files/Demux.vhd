----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.08.2019 19:56:23
-- Design Name: 
-- Module Name: Demux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Demux is
  Port (q0: in STD_LOGIC_VECTOR (3 downto 0);
        q1: in STD_LOGIC_VECTOR (3 downto 0); 
        q2: in STD_LOGIC_VECTOR (3 downto 0); 
        q3: in STD_LOGIC_VECTOR (3 downto 0); 
        e: in STD_LOGIC_VECTOR (1 downto 0); 
        seg: out STD_LOGIC_VECTOR (6 downto 0)
         );
end Demux;

architecture Behavioral of Demux is
signal ent: STD_LOGIC_VECTOR (3 downto 0);
begin
    with e select
        ent <= q0 when "00",
               q1 when "01",
               q2 when "10",
               q3 when "11",
               "0000" when others;
               
        with ent select
            seg <= "1000000" when "0000",
                   "1111001" when "0001",
                   "0100100" when "0010",
                   "0110000" when "0011",
                   "0011001" when "0100",
                   "0010010" when "0101",
                   "0000010" when "0110",
                   "1111000" when "0111",
                   "0000000" when "1000",
                   "0010000" when "1001",
                   "0001000" when "1010",
                   "0000011" when "1011",
                   "1000110" when "1100",
                   "0100001" when "1101",
                   "0000110" when "1110",
                   "0001110" when others;

end Behavioral;
