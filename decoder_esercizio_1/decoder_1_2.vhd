----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:28:29 10/15/2020 
-- Design Name: 
-- Module Name:    decoder_1_2 - Behavioral 
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

entity decoder_1_2 is
    Port ( 
			  x : in  STD_LOGIC;
           s : in  STD_LOGIC;
           y0 : out  STD_LOGIC;
			  y1 : out STD_LOGIC
			  );
end decoder_1_2;

architecture Behavioral of decoder_1_2 is

begin
	y0 <= '0' when s = '0' else
		  '1' when x = '0' else
		  '0' when x = '1' else
		  '-';
	y1 <= '0' when s = '0' else
		  '0' when x = '0' else
		  '1' when x = '1' else
		  '-';

end Behavioral;

