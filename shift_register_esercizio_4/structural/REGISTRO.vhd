----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:11:00 11/06/2020 
-- Design Name: 
-- Module Name:    REGISTRO - Behavioral 
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

entity REGISTRO is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           y : in  STD_LOGIC;
           U : out  STD_LOGIC);
end REGISTRO;

architecture Behavioral of REGISTRO is

begin
	process( CLK )
		begin
			if( CLK'event and CLK = '1' ) then
				if( RESET = '1' ) then
					U <= '0';
				else
					U <= y;
				end if;
			end if;
	end process;
end Behavioral;

