----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:29:52 11/20/2020 
-- Design Name: 
-- Module Name:    moltiplicatore - Behavioral 
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

entity moltiplicatore is
	 Generic(n : positive := 8);
    Port ( a : in  unsigned(n-1 downto 0);
           b : in  unsigned(n-1 downto 0);
			  clk : in std_logic;
			  rst : in std_logic;
           y : out  unsigned(3*n - 1 downto 0));
end moltiplicatore;

architecture Behavioral of moltiplicatore is
-- diviso 2 perché la moltiplicazione automaticamente ritorna un risultato
-- che ha dimensione in bit doppia dell'ingresso
signal zero : unsigned(n/2 - 1 downto 0) := (others => '0');

begin
molt : process(clk, rst)
begin
	if (rst = '1') then
		y <= (others => '0');
	elsif (clk = '1' and clk'event) then
		y <= (zero & a) * (zero & b);
	end if;
end process;

end Behavioral;

