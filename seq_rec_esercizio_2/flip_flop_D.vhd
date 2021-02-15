----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:51:26 10/27/2020 
-- Design Name: 
-- Module Name:    flip_flop_D - Behavioral 
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

entity flip_flop_D is
    Port ( d : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           q : out  STD_LOGIC);
end flip_flop_D;

architecture Behavioral of flip_flop_D is

begin
ff : process(clk)
begin
	if (clk = '1' and clk'event) then
		if (rst = '1') then
			q <= '0';
		else
			q <= d;
		end if;
	end if;
end process;

end Behavioral;

