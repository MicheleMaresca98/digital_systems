----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:48:05 01/03/2021 
-- Design Name: 
-- Module Name:    Switch_2_2 - Behavioral 
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

entity Switch_2_2 is
	Generic(N : integer := 6; M : integer := 3);
    Port ( i0 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           sel_u : in  STD_LOGIC_VECTOR(1 downto 0);
           u0 : out  STD_LOGIC_VECTOR(N-1 downto 0);
           u1 : out  STD_LOGIC_VECTOR(N-1 downto 0));
end Switch_2_2;

architecture Behavioral of Switch_2_2 is
component MUX_2_1 is
	Generic ( N : integer := 2 );
    Port ( i0 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
			  s : in STD_LOGIC;
           u : out  STD_LOGIC_VECTOR(N-1 downto 0));
end component;

signal shifted_0, shifted_1 : STD_LOGIC_VECTOR(N-1 downto 0);

begin

shifted_0 <= i0(N-1) & i0(N-3 downto N-M-1) & i0(N-2) & i0(N-M-2 downto 0);
shifted_1 <= i1(N-1) & i1(N-3 downto N-M-1) & i1(N-2) & i1(N-M-2 downto 0); 

mux_0: MUX_2_1 Generic map(N)
	Port map(i0 => shifted_0, i1 => shifted_1, s => sel_u(0), u => u0);
	
mux_1: MUX_2_1 Generic map(N)
	Port map(i0 => shifted_0, i1 => shifted_1, s => sel_u(1), u => u1);

end Behavioral;

