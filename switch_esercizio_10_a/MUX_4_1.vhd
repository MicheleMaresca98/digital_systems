----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:49:56 01/02/2021 
-- Design Name: 
-- Module Name:    MUX_4_1 - Dataflow 
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

entity MUX_4_1 is
    Port ( i0 : in  STD_LOGIC_VECTOR(1 downto 0);
           i1 : in  STD_LOGIC_VECTOR(1 downto 0);
           i2 : in  STD_LOGIC_VECTOR(1 downto 0);
           i3 : in  STD_LOGIC_VECTOR(1 downto 0);
           s : in  STD_LOGIC_VECTOR(1 downto 0);
           u : out  STD_LOGIC_VECTOR(1 downto 0));
end MUX_4_1;

architecture Dataflow of MUX_4_1 is

begin
	with s select
		u <= i0 when "00",
			  i1 when "01",
			  i2 when "10",
			  i3 when "11",
			  (others => '-') when others;

end Dataflow;

