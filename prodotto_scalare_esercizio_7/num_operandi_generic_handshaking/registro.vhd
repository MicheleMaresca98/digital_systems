----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:42:50 11/20/2020 
-- Design Name: 
-- Module Name:    registro - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registro is
	 Generic(n : positive := 8);
    Port ( d : in  unsigned(n-1 downto 0);
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
           q : out  unsigned(n-1 downto 0));
end registro;

architecture Behavioral of registro is

begin

memory : process(rst, en)
begin
	if (rst = '1') then
		q <= (others => '0');
	elsif (en = '1' and en'event) then
		q <= d;
	end if;
end process;

end Behavioral;

