----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:06:22 11/07/2020 
-- Design Name: 
-- Module Name:    registro_N_bit - Behavioral 
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

entity registro_N_bit is
	 Generic (n : positive := 1);
    Port ( par : in  STD_LOGIC_VECTOR(n-1 downto 0);
			  clock : in STD_LOGIC;
			  reset : in STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(n-1 downto 0));
end registro_N_bit;

architecture Behavioral of registro_N_bit is
component flip_flop_D is
    Port ( d : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           q : out  STD_LOGIC);
end component;

begin
registro : for i in 0 to n-1 generate
	ff_D : flip_flop_D Port map(
		d => par(i), clock => clock, reset => reset, q => y(i)
	);
end generate;

end Behavioral;

