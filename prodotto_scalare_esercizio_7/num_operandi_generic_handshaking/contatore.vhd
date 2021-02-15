----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:49:00 11/20/2020 
-- Design Name: 
-- Module Name:    contatore - Behavioral 
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

entity contatore is
	 Generic(n : positive := 8);
    Port ( clk : in  STD_LOGIC;
           set : in  STD_LOGIC;
           par : in  unsigned(n-1 downto 0);
           rst : in  STD_LOGIC;
           overflow : out  STD_LOGIC);
end contatore;

architecture Behavioral of contatore is

signal cnt : unsigned(n-1 downto 0) := (others => '0');

begin
count : process(clk, set, rst)
constant maximum : unsigned(n-1 downto 0) := (others => '1');
begin
	if (rst = '1') then
		cnt <= (others => '0'); overflow <= '0';
	elsif (set = '1') then
		cnt <= par; overflow <= '0';
	elsif (clk = '1' and clk'event) then
		if (cnt = maximum) then
			cnt <= (others => '0');
			overflow <= '1';
		else
			cnt <= cnt + 1;
			overflow <= '0';
		end if;
	end if;
end process;

end Behavioral;

