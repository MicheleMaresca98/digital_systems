----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:06:09 01/03/2021 
-- Design Name: 
-- Module Name:    switch_8 - Behavioral 
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

entity switch_8 is
	Generic(N: integer :=3);
    Port ( i0 : in  STD_LOGIC_VECTOR ( N-1 DOWNTO 0 );
           i1 : in  STD_LOGIC_VECTOR ( N-1 DOWNTO 0 );
           i2 : in  STD_LOGIC_VECTOR ( N-1 DOWNTO 0 );
           i3 : in  STD_LOGIC_VECTOR ( N-1 DOWNTO 0 );
           i4 : in  STD_LOGIC_VECTOR ( N-1 DOWNTO 0 );
           i5 : in  STD_LOGIC_VECTOR ( N-1 DOWNTO 0 );
           i6 : in  STD_LOGIC_VECTOR ( N-1 DOWNTO 0 );
           i7 : in  STD_LOGIC_VECTOR ( N-1 DOWNTO 0 );
			  dest_i0 : in  STD_LOGIC_VECTOR ( 2 DOWNTO 0 );
           dest_i1 : in  STD_LOGIC_VECTOR ( 2 DOWNTO 0 );
           dest_i2 : in  STD_LOGIC_VECTOR ( 2 DOWNTO 0 );
           dest_i3 : in  STD_LOGIC_VECTOR ( 2 DOWNTO 0 );
           dest_i4 : in  STD_LOGIC_VECTOR ( 2 DOWNTO 0 );
           dest_i5 : in  STD_LOGIC_VECTOR ( 2 DOWNTO 0 );
           dest_i6 : in  STD_LOGIC_VECTOR ( 2 DOWNTO 0 );
           dest_i7 : in  STD_LOGIC_VECTOR ( 2 DOWNTO 0 );
           u0 : out  STD_LOGIC_VECTOR ( N+6-1 DOWNTO 0 );
           u1 : out  STD_LOGIC_VECTOR ( N+6-1 DOWNTO 0 );
           u2 : out  STD_LOGIC_VECTOR ( N+6-1 DOWNTO 0 );
           u3 : out  STD_LOGIC_VECTOR ( N+6-1 DOWNTO 0 );
           u4 : out  STD_LOGIC_VECTOR ( N+6-1 DOWNTO 0 );
           u5 : out  STD_LOGIC_VECTOR ( N+6-1 DOWNTO 0 );
           u6 : out  STD_LOGIC_VECTOR ( N+6-1 DOWNTO 0 );
           u7 : out  STD_LOGIC_VECTOR ( N+6-1 DOWNTO 0 ));
end switch_8;

architecture Behavioral of switch_8 is

component omega_network is
	Generic(N: integer :=6; M: integer :=3);
    Port ( i : in  STD_LOGIC_VECTOR(N*2**M - 1 downto 0);
           u : out  STD_LOGIC_VECTOR(N*2**M - 1 downto 0));
end component;
signal i,exit_u : std_logic_vector ((N+6)*2**3 - 1 downto 0):= (others => '0');

begin

i <= i7(N-1)& dest_i7 & "111" & i7(N-2 downto 0) & i6(N-1) & dest_i6 & "110"& i6(N-2 downto 0) & i5(N-1) & dest_i5 & "101" & i5(N-2 downto 0) & i4(N-1) & dest_i4 & "100" & i4(N-2 downto 0) & i3(N-1) & dest_i3 & "011"& i3(N-2 downto 0) & i2(N-1) & dest_i2 & "010" & i2(N-2 downto 0) & i1(N-1) & dest_i1 & "001" & i1(N-2 downto 0) & i0(N-1) & dest_i0 & "000" & i0(N-2 downto 0);
omega_network_8_nodi : omega_network generic map (N+6,3)
	Port map(
		i => i,
		u => exit_u);
--		u((N+3)*8-1 downto (N+3)*7) => u7,
--		u((N+3)*7-1 downto (N+3)*6) => u6,
--		u((N+3)*6-1 downto (N+3)*5) => u5,
--		u((N+3)*5-1 downto (N+3)*4) => u4,
--		u((N+3)*4-1 downto (N+3)*3) => u3,
--		u((N+3)*3-1 downto (N+3)*2) => u2,
--		u((N+3)*2-1 downto (N+3)*1) => u1,
--		u((N+3)-1 downto  0) => u0);	

		u7 <= exit_u((N+6)*8-1 downto (N+6)*7);
		u6 <= exit_u((N+6)*7-1 downto (N+6)*6);
		u5 <= exit_u((N+6)*6-1 downto (N+6)*5);
		u4 <= exit_u((N+6)*5-1 downto (N+6)*4);
		u3 <= exit_u((N+6)*4-1 downto (N+6)*3);
		u2 <= exit_u((N+6)*3-1 downto (N+6)*2);
		u1 <= exit_u((N+6)*2-1 downto (N+6)*1);
		u0 <= exit_u((N+6)-1 downto  0);
			
end Behavioral;

