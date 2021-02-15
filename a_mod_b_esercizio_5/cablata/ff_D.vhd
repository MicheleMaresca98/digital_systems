----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:38:56 11/10/2020 
-- Design Name: 
-- Module Name:    ff_D - Behavioral 
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

entity ff_D is
    Port ( d : in  STD_LOGIC;
           en : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           q : out  STD_LOGIC);
end ff_D;

architecture Behavioral of ff_D is

begin
ff : process(en)
begin
	if (rst = '1') then
		q <= '0';
	elsif (en = '1' and en'event) then
		q <= d;
	end if;
end process;

end Behavioral;

