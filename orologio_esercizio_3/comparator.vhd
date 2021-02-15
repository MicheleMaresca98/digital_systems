----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:17:34 11/07/2020 
-- Design Name: 
-- Module Name:    comparator - Behavioral 
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

entity comparator is
	 Generic (n : positive := 2);
    Port ( a : in  STD_LOGIC_VECTOR(n-1 downto 0);
           b : in  STD_LOGIC_VECTOR(n-1 downto 0);
			  clk : in STD_LOGIC;
           y : out  STD_LOGIC);
end comparator;

architecture Behavioral of comparator is

begin
comp : process(clk)
begin
	if (clk = '0' and clk'event) then
		if a = b then
			y <= '1';
		else
			y <= '0';
		end if;
	end if;
end process;

end Behavioral;

