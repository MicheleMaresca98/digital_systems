----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:15:15 11/21/2020 
-- Design Name: 
-- Module Name:    Registro - Structural 
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

entity Registro is
    Port ( CLK : in  STD_LOGIC;
           EN: in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR(15 downto 0);
           Q : out  STD_LOGIC_VECTOR(15 downto 0)
	 );
end Registro;

architecture Structural of Registro is
	
	component FlipFlop is
		port( CLK : in  STD_LOGIC;
			  EN: in STD_LOGIC;
			  RESET: in STD_LOGIC;
		     D : in  STD_LOGIC;
           Q : out  STD_LOGIC
			 );
	end component;
	
begin
	
	reg15to0: for i in 15 downto 0 generate
	FF: FlipFlop
		Port map( CLK => CLK,
			        EN => EN,
						RESET => RESET,
						D => D(i),
						Q => Q(i)
					);
	end generate;
						
end Structural;
