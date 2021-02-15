----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:18:25 01/02/2021 
-- Design Name: 
-- Module Name:    UC_omega_network_4 - Structural 
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

entity UC_omega_network_4 is
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
end UC_omega_network_4;

architecture Structural of UC_omega_network_4 is

component retepriorita is
    Port ( en0 : in  STD_LOGIC;
           en1 : in  STD_LOGIC;
           en2 : in  STD_LOGIC;
           en3 : in  STD_LOGIC;
           u_prio : out  STD_LOGIC_VECTOR(1 downto 0));
end component;

component MUX_4_1 is
    Port ( i0 : in  STD_LOGIC_VECTOR(1 downto 0);
           i1 : in  STD_LOGIC_VECTOR(1 downto 0);
			  i2 : in  STD_LOGIC_VECTOR(1 downto 0);
			  i3: in  STD_LOGIC_VECTOR(1 downto 0);
			  s : in STD_LOGIC_VECTOR(1 downto 0);
           u : out  STD_LOGIC_VECTOR(1 downto 0));
end component;

signal internal_sel_src : STD_LOGIC_VECTOR(1 DOWNTO 0) :=  (others => '0');

begin

src: retepriorita
	Port map(en0 => en_i0, en1 => en_i1, en2 => en_i2, en3 => en_i3, u_prio => internal_sel_src);

dest: MUX_4_1
	Port map(i0 => dest_i0, i1 => dest_i1, i2 => dest_i2, i3 => dest_i3, s => internal_sel_src, u => sel_dest);

sel_src <= internal_sel_src;

end Structural;
