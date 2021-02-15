----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:03:31 11/07/2020 
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
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           q : out  STD_LOGIC);
end flip_flop_D;

architecture Behavioral of flip_flop_D is
signal q_tmp : std_logic := '0';
begin
ff_D: process(clock, reset)
begin
	if (reset = '1') then
		q_tmp <= '0';
	elsif (clock = '0' and clock'event) then
		q_tmp <= d;
	end if;
end process;

q <= q_tmp;

end Behavioral;

