----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:43:12 01/05/2021 
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
	 Generic(N : integer := 8);
    Port ( op1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           op2 : in  STD_LOGIC_VECTOR(N-1 downto 0);
			  cin : in STD_LOGIC;
           res : out  STD_LOGIC_VECTOR(N-1 downto 0);
           cout : out  STD_LOGIC);
end adder;

architecture Behavioral of adder is

signal sum : std_logic_vector(N downto 0);
signal zero : std_logic_vector(N-2 downto 0) := (others => '0');
signal op1_s, op2_s, extended_cin : signed(N-1 downto 0);

begin

extended_cin <= signed(zero & cin);
op1_s <= signed(op1);
op2_s <= signed(op2);
sum <= std_logic_vector(op1_s + op2_s + extended_cin);
res <= sum(N-1 downto 0);
cout <= sum(N);

end Behavioral;

