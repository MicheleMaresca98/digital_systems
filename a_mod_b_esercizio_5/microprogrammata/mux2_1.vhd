----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:26:20 11/11/2020 
-- Design Name: 
-- Module Name:    MUX2_1 - Dataflow 
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

entity mux2_1 is
    Port ( I0 : in STD_LOGIC_VECTOR(7 downto 0);
			  I1 : in STD_LOGIC_VECTOR(7 downto 0);
           S : in  STD_LOGIC;
           U : out STD_LOGIC_VECTOR(7 downto 0)
			  );
end mux2_1;

architecture df of mux2_1 is

begin
	with S select
		U <= I0 when '0',
			  I1 when '1',
			  (others => '-') when others;
end df;

