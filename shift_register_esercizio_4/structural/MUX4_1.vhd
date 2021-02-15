----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:16:54 11/06/2020 
-- Design Name: 
-- Module Name:    MUX4_1 - Structural 
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

entity MUX4_1 is
    Port ( I : in  STD_LOGIC_VECTOR(0 to 3);
           S : in  STD_LOGIC_VECTOR(1 downto 0);
           U : out  STD_LOGIC);
end MUX4_1;

architecture Structural of MUX4_1 is
signal Y : STD_LOGIC_VECTOR(0 to 1) := (others => '0');
	component MUX2_1
		port( I : in STD_LOGIC_VECTOR(1 downto 0);
				S : in STD_LOGIC;
				U : out STD_LOGIC
				);
	end component;
	
begin
	mux0to1: FOR j IN 0 TO 1 GENERATE
		m: MUX2_1
		Port map(	I => I(j*2 to j*2+1),
						S => S(0),
						U => Y(j)
					);
	END GENERATE;
	
	mux2: MUX2_1
		Port map(	I => Y(0 to 1),
						S => S(1),
						U => U
					);
						
end Structural;

