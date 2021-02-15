----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:59:31 11/10/2020 
-- Design Name: 
-- Module Name:    not_N_bit - Behavioral 
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

entity not_N_bit is
	 Generic(n : positive := 8);
    Port ( x : in  STD_LOGIC_VECTOR(n-1 downto 0);
           y : out  STD_LOGIC_VECTOR(n-1 downto 0));
end not_N_bit;

architecture Behavioral of not_N_bit is

begin
y <= std_logic_vector(to_signed(- to_integer(signed(x)), n));

end Behavioral;

