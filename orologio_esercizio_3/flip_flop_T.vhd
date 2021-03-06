----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:15:29 11/07/2020 
-- Design Name: 
-- Module Name:    flip_flop_T - Behavioral 
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

entity flip_flop_T is
    Port ( t : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  set : in STD_LOGIC;
			  d : in STD_LOGIC;
           rst : in  STD_LOGIC;
           q : out  STD_LOGIC);
end flip_flop_T;

architecture Behavioral of flip_flop_T is
signal q_tmp : std_logic := '0';

begin
ff_T: process(clk, rst)
begin
	if (rst = '1') then
		q_tmp <= '0';
	elsif (set = '1') then
		q_tmp <= d;
	elsif (clk = '0' and clk'event) then
		if (t = '1') then
			q_tmp <= not q_tmp;
		end if;
	end if;
end process;

q <= q_tmp;

end Behavioral;

