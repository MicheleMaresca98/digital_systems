----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:31:29 11/18/2020 
-- Design Name: 
-- Module Name:    Ripple_Carry - Behavioral 
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

entity Ripple_Carry is
    Port ( x : in  STD_LOGIC_VECTOR(7 downto 0);
           y : in  STD_LOGIC_VECTOR(7 downto 0);
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR(7 downto 0);
           Cout : out  STD_LOGIC);
end Ripple_Carry;

architecture Behavioral of Ripple_Carry is

signal extended_x : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');
signal extended_y : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');
signal extended_cin : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');
signal extended_sum : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');


begin  

extended_x <='0'&x;
extended_y <='0'&y;
extended_cin <= "00000000"&Cin;
extended_sum <= std_logic_vector(unsigned(extended_x) + unsigned(extended_y) + unsigned(extended_cin));
Cout <= extended_sum(8);
Sum <= extended_sum(7 downto 0);

end Behavioral;

