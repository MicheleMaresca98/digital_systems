----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:42:08 11/10/2020 
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
	 Generic(n : positive := 8);
    Port ( par : in  STD_LOGIC_VECTOR(n-1 downto 0);
           en : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(n-1 downto 0));
end registro_N_bit;

architecture Behavioral of registro_N_bit is

component ff_D is
    Port ( d : in  STD_LOGIC;
           en : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           q : out  STD_LOGIC);
end component;

begin
banco_ff : for i in 0 to n-1 generate
	ff_i : ff_D port map(
		d => par(i), en => en, q => y(i), rst => rst
	);
end generate;

end Behavioral;

