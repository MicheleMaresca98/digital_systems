----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:40:13 11/10/2020 
-- Design Name: 
-- Module Name:    mux_2_1 - Behavioral 
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

entity mux_2_1 is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           y : out  STD_LOGIC);
end mux_2_1;

architecture Behavioral of mux_2_1 is

begin
y <= (a and (not sel)) or (b and sel);


end Behavioral;

