----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:32:04 01/02/2021 
-- Design Name: 
-- Module Name:    SWITCH_2_2 - Structural 
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

entity SWITCH_2_2 is
	Generic ( N : integer := 2 );
    Port ( i0 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           sel_src : in  STD_LOGIC;
           sel_dest : in  STD_LOGIC;
           u0 : out  STD_LOGIC_VECTOR(N-1 downto 0);
           u1 : out  STD_LOGIC_VECTOR(N-1 downto 0));
end SWITCH_2_2;

architecture Structural of SWITCH_2_2 is

component MUX_2_1 is
	Generic ( N : integer := 2 );
    Port ( i0 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
			  s : in STD_LOGIC;
           u : out  STD_LOGIC_VECTOR(N-1 downto 0));
end component;

component DEMUX_1_2 is
	Generic ( N : integer := 2 );
    Port ( i : in  STD_LOGIC_VECTOR(N-1 downto 0);
			  s : in STD_LOGIC;
           u0 : out  STD_LOGIC_VECTOR(N-1 downto 0);
			  u1 : out  STD_LOGIC_VECTOR(N-1 downto 0));
end component;

signal i : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');

begin
mux: MUX_2_1
	generic map(2)
	port map(i0 => i0, i1 => i1, s => sel_src, u => i); 
demux: DEMUX_1_2
	generic map(2)
	port map(i => i, s => sel_dest, u0 => u0, u1 => u1);
end Structural;

