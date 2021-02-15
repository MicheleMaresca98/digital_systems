----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:04:27 11/06/2020 
-- Design Name: 
-- Module Name:    FF_T - Behavioral 
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
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
			  A : in STD_LOGIC;
			  LOAD : in STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end FF_D;

architecture Behavioral of FF_D is
	signal QINTERNAL: std_logic;
begin

	ff: process(CLK)
	begin
		if(CLK'event and CLK = '1') then
			if(RESET = '1') then
				QINTERNAL <= '0';
			elsif(LOAD = '1') then
				QINTERNAL <= A;
			else
				QINTERNAL <= D;
			end if;
		end if;
	end process;
	
	Q <= QINTERNAL;

end Behavioral;

