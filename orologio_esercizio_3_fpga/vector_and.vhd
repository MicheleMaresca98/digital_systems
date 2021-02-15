----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:25:15 11/07/2020 
-- Design Name: 
-- Module Name:    vector_and - Behavioral 
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

entity vector_and is
	 Generic (n : positive := 2);
    Port ( a : in  STD_LOGIC_VECTOR(n-1 downto 0);
           b : in  STD_LOGIC_VECTOR(n-1 downto 0);
           y : out  STD_LOGIC);
end vector_and;

architecture Structural of vector_and is
signal u : std_logic_vector(n-1 downto 0) := (others => '0');

component logic_and is
	 Generic ( n : positive := 2 );
    Port ( a : in  STD_LOGIC_VECTOR(n-1 downto 0);
           y : out  STD_LOGIC);
end component;

begin
bit_to_bit : for i in 0 to n-1 generate
	and_i : logic_and generic map(2) port map(
		a(0) => a(i), a(1) => b(i), y => u(i)
	);
end generate;

last_and : logic_and generic map(n) port map(
	a => u, y => y
);

end Structural;

