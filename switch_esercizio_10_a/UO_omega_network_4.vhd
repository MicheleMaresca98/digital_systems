----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:55:46 01/02/2021 
-- Design Name: 
-- Module Name:    UO_omega_network_4 - Structural 
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

entity UO_omega_network_4 is
	Generic (N : integer := 2);
    Port ( i0 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i2 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i3 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           sel_src : in  STD_LOGIC_VECTOR(1 downto 0);
           sel_dest : in  STD_LOGIC_VECTOR(1 downto 0);
           u0 : out  STD_LOGIC_VECTOR(N-1 downto 0);
           u1 : out  STD_LOGIC_VECTOR(N-1 downto 0);
           u2 : out  STD_LOGIC_VECTOR(N-1 downto 0);
           u3 : out  STD_LOGIC_VECTOR(N-1 downto 0));
end UO_omega_network_4;

architecture Structural of UO_omega_network_4 is

component SWITCH_2_2 is
	Generic ( N : integer := 2 );
    Port ( i0 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           sel_src : in  STD_LOGIC;
           sel_dest : in  STD_LOGIC;
           u0 : out  STD_LOGIC_VECTOR(N-1 downto 0);
           u1 : out  STD_LOGIC_VECTOR(N-1 downto 0));
end component;

signal i0_1, i1_1, i0_3, i1_3 : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');

begin
	switch_0: SWITCH_2_2 generic map(N)
		port map(i0 => i0, i1 => i2, sel_src => sel_src(1), sel_dest => sel_dest(1), u0 => i0_1, u1 => i0_3);
	switch_1: SWITCH_2_2 generic map(N)
		port map(i0 => i0_1, i1 => i1_1, sel_src => sel_src(0), sel_dest => sel_dest(0), u0 => u0 ,u1 => u1);
	switch_2: SWITCH_2_2 generic map(N)
		port map(i0 => i1, i1 => i3, sel_src => sel_src(1), sel_dest => sel_dest(1),u0 => i1_1 ,u1 => i1_3 );
	switch_3: SWITCH_2_2 generic map(N)
		port map(i0 => i0_3, i1 => i1_3, sel_src => sel_src(0), sel_dest => sel_dest(0), u0 => u2, u1 => u3);
end Structural;

