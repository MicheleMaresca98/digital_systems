----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:23:51 11/20/2020 
-- Design Name: 
-- Module Name:    sommatore - Behavioral 
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

entity sommatore is
	 Generic (n : positive := 8);
    Port ( a : in  unsigned(n-1 downto 0);
           b : in  unsigned(n-1 downto 0);
			  clk : in std_logic;
			  rst : in std_logic;
           y : out  unsigned(n-1 downto 0));
-- dev'essere questa la dimensione dell'uscita altrimenti non si può mettere in feedback nel registro
end sommatore;

architecture Behavioral of sommatore is

begin
somma : process(clk, rst)
begin
	if (rst = '1') then
		y <= (others => '0');
	elsif (clk = '1' and clk'event) then
		y <= a + b;
	end if;
end process;

end Behavioral;

