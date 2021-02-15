----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:33:10 11/18/2020 
-- Design Name: 
-- Module Name:    FF_D - Behavioral 
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

entity FF_D is

port (
	clk, en, reset : in std_logic;
	D : in std_logic_vector ( 7 downto 0 );
	Q : out std_logic_vector ( 7 downto 0 ));

end FF_D;

architecture Behavioral of FF_D is

begin

process (clk)
	begin
		if (clk'event and clk = '1') then
			if reset = '1' then
				Q <= "00000000";
			elsif en = '1' then
				Q <= D;
			end if;
		end if;
end process;

end Behavioral;

