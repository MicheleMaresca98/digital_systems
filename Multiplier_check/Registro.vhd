----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:36:34 01/05/2021 
-- Design Name: 
-- Module Name:    Registro - Behavioral 
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
	Generic( N : integer := 8);
    Port ( CLK : in  STD_LOGIC;
           EN: in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR(N-1 downto 0);
           Q : out  STD_LOGIC_VECTOR(N-1 downto 0)
	 );
end Registro;

architecture Structural of Registro is
	
	component FLIP_FLOP_D is
		port( CLK : in  STD_LOGIC;
			  EN: in STD_LOGIC;
			  RESET: in STD_LOGIC;
		     D : in  STD_LOGIC;
           Q : out  STD_LOGIC
			 );
	end component;
	
begin
	
	regN_1to0: for i in N-1 downto 0 generate
	FF: FLIP_FLOP_D
		Port map( CLK => CLK,
			        EN => EN,
						RESET => RESET,
						D => D(i),
						Q => Q(i)
					);
	end generate;
						
end Structural;


