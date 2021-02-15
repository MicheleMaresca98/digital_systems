----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:06:01 10/22/2012 
-- Design Name: 
-- Module Name:    clock_filter - Behavioral 
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

entity clock_filter is
	 generic(
				clock_frequency_in : integer := 50000000;
				clock_frequency_out : integer := 5000000
				);
    Port ( clock_in : in  STD_LOGIC;
				reset_n : in STD_LOGIC;
           clock_out : out  STD_LOGIC);
end clock_filter;

architecture Behavioral of clock_filter is

signal clockfx, reset : std_logic := '0';

constant count_max_value : integer := (clock_frequency_in/(clock_frequency_out))-1;

begin

clock_out <= clockfx;
reset <= not reset_n;

count_for_division: process(clock_in, reset)
variable counter : integer range 0 to count_max_value := 0;
begin

	if reset = '1' then
		counter := 0;
		clockfx <= '0';
	elsif clock_in'event and clock_in = '1' then
		if counter = count_max_value then
			clockfx <=  '1';
			counter := 0;
		else
			clockfx <=  '0';
			counter := counter + 1;
		end if;
	end if;

end process;


end Behavioral;

