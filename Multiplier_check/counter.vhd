----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:48:03 01/05/2021 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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

entity counter is
	Generic(N : integer := 3; M : integer := 7);
	--N rappresenta l'esponente di 2, es. N=3, il contatore si comporta come modulo8
	--M rappresenta il valore di overflow
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  enable : in STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (N-1 downto 0);
			  overflow : out STD_LOGIC);
end counter;

architecture Behavioral of counter is

signal c : std_logic_vector (N-1 downto 0) := (others => '0');

begin

count <= c;

counter_process: process(clock, reset)
begin
	
	if reset = '1' then
		c <= (others => '0'); 
		overflow <= '0';
	elsif clock'event AND clock = '1' AND enable = '1' then
		if to_integer(unsigned(c)) = (M - 1) then
			c <= (others => '0');
			overflow <= '1';
		else
			c <= std_logic_vector(unsigned(c) + 1);
			overflow <= '0';
		end if;
	end if;
	
end process;

end Behavioral;

