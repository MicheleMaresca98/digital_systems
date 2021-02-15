----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:48:12 11/10/2020 
-- Design Name: 
-- Module Name:    registro_N_bit_multiplexed - Behavioral 
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

entity registro_N_bit_multiplexed is
    Generic(n : positive := 8);
    Port ( sel : in  STD_LOGIC;
           en : in  STD_LOGIC;
           a : in  STD_LOGIC_VECTOR(n-1 downto 0);
           b : in  STD_LOGIC_VECTOR(n-1 downto 0);
			  rst : in STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(n-1 downto 0));
end registro_N_bit_multiplexed;

architecture Behavioral of registro_N_bit_multiplexed is
signal u : std_logic_vector(n-1 downto 0) := (others => '0');

component mux_2_1_parallelo_N is
    Generic(n : positive := 8);
    Port ( a : in  STD_LOGIC_VECTOR(n-1 downto 0);
           b : in  STD_LOGIC_VECTOR(n-1 downto 0);
           sel : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

component registro_N_bit is
	 Generic(n : positive := 8);
    Port ( par : in  STD_LOGIC_VECTOR(n-1 downto 0);
           en : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

begin
mux : mux_2_1_parallelo_N generic map(n => n) port map(
	a => a, b => b, sel => sel, y => u
);

registro : registro_N_bit generic map(n => n) port map(
	par => u, en => en, y => y, rst => rst
);

end Behavioral;

