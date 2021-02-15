----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:21:27 01/02/2021 
-- Design Name: 
-- Module Name:    DEMUX_1_2 - Behavioral 
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

entity DEMUX_1_2 is
	Generic ( N : integer := 2 );
    Port ( i : in  STD_LOGIC_VECTOR(N-1 downto 0);
			  s : in STD_LOGIC;
           u0 : out  STD_LOGIC_VECTOR(N-1 downto 0);
			  u1 : out  STD_LOGIC_VECTOR(N-1 downto 0));
end DEMUX_1_2;

architecture Dataflow of DEMUX_1_2 is

begin
		u0 <= i when s = '0' else (others => '-');
		u1 <= i when s = '1' else (others => '-');
end Dataflow;

