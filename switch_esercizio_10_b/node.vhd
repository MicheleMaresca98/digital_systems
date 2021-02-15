----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:10:49 01/03/2021 
-- Design Name: 
-- Module Name:    node - Structural 
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

entity node is
	Generic(N : integer := 6; M : integer := 3);
    Port ( i0 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           u0 : out  STD_LOGIC_VECTOR(N-1 downto 0);
           u1 : out  STD_LOGIC_VECTOR(N-1 downto 0));
end node;

architecture Structural of node is
component Switch_2_2 is
	Generic(N : integer := 6; M : integer := 3);
    Port ( i0 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           sel_u : in  STD_LOGIC_VECTOR(1 downto 0);
           u0 : out  STD_LOGIC_VECTOR(N-1 downto 0);
           u1 : out  STD_LOGIC_VECTOR(N-1 downto 0));
end component;
component switch_control is
    Port ( en_i0 : in  STD_LOGIC;
           en_i1 : in  STD_LOGIC;
           dest_i0 : in  STD_LOGIC;
           dest_i1 : in  STD_LOGIC;
           sel_u : out  STD_LOGIC_VECTOR(1 downto 0));
end component;

signal sel_u : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
begin

switch: Switch_2_2 Generic map(N,M)
	Port map(i0 => i0, i1 => i1, sel_u => sel_u, u0 => u0, u1 => u1);

control: switch_control
	Port map(en_i0 => i0(N-1), en_i1 => i1(N-1), dest_i0 => i0(N-2), dest_i1 => i1(N-2), sel_u => sel_u);

end Structural;

