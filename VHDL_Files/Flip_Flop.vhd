----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:12:44 05/02/2019 	
-- Design Name: 
-- Module Name:    Defasador - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Flip_Flop is
	port (
			q: out std_logic;
			clk, d: in std_logic
	);
end Flip_Flop;

architecture Behavioral of Flip_Flop is
	
begin

process(clk)
begin
	if(clk'event and clk='1') then
		q <= d;
	end if;
end process;
 
end Behavioral;

