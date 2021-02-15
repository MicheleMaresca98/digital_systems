----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:42:25 10/27/2020 
-- Design Name: 
-- Module Name:    and - Behavioral 
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

entity logic_and is
	 Generic ( n : positive := 2 );
    Port ( a : in  STD_LOGIC_VECTOR(n-1 downto 0);
           y : out  STD_LOGIC);
end logic_and;

architecture Behavioral of logic_and is

begin
	and_func : process(a)
		variable result : std_logic;	
		begin
		result := '1';
		for i in 0 to n-1 loop
			result := result and a(i);
		end loop;
		y <= result;
	end process;
end Behavioral;

