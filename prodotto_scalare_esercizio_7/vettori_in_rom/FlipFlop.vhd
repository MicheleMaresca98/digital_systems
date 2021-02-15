----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:14:32 11/21/2020 
-- Design Name: 
-- Module Name:    FlipFlop - Behavioral 
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

entity FlipFlop is
    Port ( CLK : in  STD_LOGIC;
			  EN : in STD_LOGIC;
			  RESET: in STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC
			 );
			 
end FlipFlop;

architecture rtl of FlipFlop is
	begin
		ff: process( CLK )
		begin
			if( CLK'event and CLK = '1' ) then
				if( RESET = '1' ) then
					Q <= '0';
				elsif(EN= '1') then
					Q <= D;
				end if;
			end if;
		end process;
		
end rtl;


