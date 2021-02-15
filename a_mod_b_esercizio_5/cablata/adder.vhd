----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:27:11 11/10/2020 
-- Design Name: 
-- Module Name:    adder - Behavioral 
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

entity adder is
	 Generic(n : positive := 8);
    Port ( a : in  STD_LOGIC_VECTOR(n-1 downto 0);
           b : in  STD_LOGIC_VECTOR(n-1 downto 0);
           y : out  STD_LOGIC_VECTOR(n-1 downto 0);
			  cout : out STD_LOGIC);
end adder;

architecture Behavioral of adder is

begin
y <= std_logic_vector(to_signed(to_integer(signed(a)) + to_integer(signed(b)), n));

carry : process(a, b)
begin
	if ((to_integer(signed(a)) + to_integer(signed(b))) <  0) then
		cout <= '1';
	else
		cout <= '0';
	end if;
end process;

end Behavioral;

