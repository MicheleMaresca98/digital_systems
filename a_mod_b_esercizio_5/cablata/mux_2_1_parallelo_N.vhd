----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:44:56 11/10/2020 
-- Design Name: 
-- Module Name:    mux_2_1_parallelo_N - Behavioral 
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

entity mux_2_1_parallelo_N is
    Generic(n : positive := 8);
    Port ( a : in  STD_LOGIC_VECTOR(n-1 downto 0);
           b : in  STD_LOGIC_VECTOR(n-1 downto 0);
           sel : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(n-1 downto 0));
end mux_2_1_parallelo_N;

architecture Behavioral of mux_2_1_parallelo_N is

component mux_2_1 is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           y : out  STD_LOGIC);
end component;

begin
banco_mux : for i in 0 to n-1 generate
	mux_i : mux_2_1 port map(
		a => a(i), b => b(i), sel => sel, y => y(i)
	);
end generate;

end Behavioral;

