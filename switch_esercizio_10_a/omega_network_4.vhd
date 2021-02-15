----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:54:12 01/02/2021 
-- Design Name: 
-- Module Name:    omega_network_4 - Structural 
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

entity omega_network_4 is
	Generic (N : integer := 2);
    Port ( i0 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i2 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i3 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           en_i0 : in  STD_LOGIC;
           en_i1 : in  STD_LOGIC;
           en_i2 : in  STD_LOGIC;
           en_i3 : in  STD_LOGIC;
           dest_i0 : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
           dest_i1 : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
           dest_i2 : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
           dest_i3 : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
           u0 : out  STD_LOGIC_VECTOR(N-1 downto 0);
           u1 : out  STD_LOGIC_VECTOR(N-1 downto 0);
           u2 : out  STD_LOGIC_VECTOR(N-1 downto 0);
           u3 : out  STD_LOGIC_VECTOR(N-1 downto 0));
end omega_network_4;

architecture Structural of omega_network_4 is
component UO_omega_network_4 is
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
end component;

component UC_omega_network_4 is
    Port ( en_i0 : in  STD_LOGIC;
           en_i1 : in  STD_LOGIC;
           en_i2 : in  STD_LOGIC;
           en_i3 : in  STD_LOGIC;
           dest_i0 : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
           dest_i1 : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
           dest_i2 : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
           dest_i3 : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
           sel_src : out  STD_LOGIC_VECTOR(1 DOWNTO 0);
           sel_dest : out  STD_LOGIC_VECTOR(1 DOWNTO 0));
end component;

signal sel_src : STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0');
signal sel_dest : STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0');

begin
UO: UO_omega_network_4
	Generic map(N)
	Port map(i0 => i0, i1 => i1, i2 => i2, i3 => i3, sel_src => sel_src, sel_dest => sel_dest, u0 => u0, u1 => u1, u2 => u2, u3 => u3);

UC: UC_omega_network_4
	Port map(en_i0 => en_i0, en_i1 => en_i1, en_i2 => en_i2, en_i3 => en_i3, dest_i0 => dest_i0, dest_i1 => dest_i1, dest_i2 => dest_i2, dest_i3 => dest_i3, sel_src => sel_src, sel_dest => sel_dest); 

end Structural;

