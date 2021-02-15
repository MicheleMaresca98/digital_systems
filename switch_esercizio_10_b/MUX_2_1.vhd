----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:58:08 01/03/2021 
-- Design Name: 
-- Module Name:    MUX_2_1 - Behavioral 
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

entity MUX_2_1 is
	Generic ( N : integer := 2 );
    Port ( i0 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
			  s : in STD_LOGIC;
           u : out  STD_LOGIC_VECTOR(N-1 downto 0));
end MUX_2_1;

architecture Dataflow of MUX_2_1 is

begin
		with s select
		u <= i0 when '0',
			  i1 when '1',
			  (others => '-') when others;

end Dataflow;

