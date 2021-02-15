----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:33:19 10/30/2020 
-- Design Name: 
-- Module Name:    ff_D_async_rst - Behavioral 
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

entity ff_D_async_rst is
    Port ( i : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           q : out  STD_LOGIC);
end ff_D_async_rst;

architecture Behavioral of ff_D_async_rst is
signal q_tmp : std_logic := '0';

begin
ff_D : process(clk, rst)
begin
	if (rst = '1') then
		q_tmp <= '0';
	elsif (clk = '1' and clk'event) then
		q_tmp <= i;
	end if;
end process;

q <= q_tmp;

end Behavioral;

