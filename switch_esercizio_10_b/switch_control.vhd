----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:03:11 01/03/2021 
-- Design Name: 
-- Module Name:    switch_control - Behavioral 
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

entity switch_control is
    Port ( en_i0 : in  STD_LOGIC;
           en_i1 : in  STD_LOGIC;
           dest_i0 : in  STD_LOGIC;
           dest_i1 : in  STD_LOGIC;
           sel_u : out  STD_LOGIC_VECTOR(1 downto 0));
end switch_control;

architecture Behavioral of switch_control is

begin
	UC: process (en_i0, en_i1, dest_i0, dest_i1)
		variable d_i0, d_i1 : integer range 0 to 1 := 0;
		begin
		if dest_i0 = '1' then
			d_i0 := 1;
		else 
			d_i0 := 0;
		end if;
		sel_u <= "--";
		if dest_i1 = '1' then
			d_i1 := 1;
		else 
			d_i1 := 0;
		end if;
		if en_i0='1' and en_i1='1' then
			if d_i0 /= d_i1 then  -- /= operatore diverso
				sel_u(d_i1) <= '1';
			end if;
			sel_u(d_i0) <= '0';
		elsif en_i0 = '1' then
			sel_u(d_i0)  <= '0';
		elsif en_i1 = '1' then
			sel_u(d_i1) <= '1';
		end if;
	end process;

end Behavioral;

