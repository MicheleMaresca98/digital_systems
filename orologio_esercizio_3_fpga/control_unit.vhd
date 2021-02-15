----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:59:27 10/23/2012 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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

entity control_unit is
    Port ( 
		   clock : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
		   preset : in  STD_LOGIC;
           value : out  STD_LOGIC_VECTOR(31 downto 0);
           enable : out  STD_LOGIC_VECTOR(7 downto 0)
			  );
end control_unit;

architecture Structural of control_unit is

signal reset : std_logic;
signal u_s : std_logic_vector(5 downto 0) := (others => '0');
signal u_m : std_logic_vector(5 downto 0) := (others => '0');
signal u_h : std_logic_vector(5 downto 0) := (others => '0');

component orologio is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           preset : in  STD_LOGIC;
           set_s : in  STD_LOGIC_VECTOR(5 downto 0);
           set_m : in  STD_LOGIC_VECTOR(5 downto 0);
           set_h : in  STD_LOGIC_VECTOR(4 downto 0);
           s : out  STD_LOGIC_VECTOR(5 downto 0);
           m : out  STD_LOGIC_VECTOR(5 downto 0);
           h : out  STD_LOGIC_VECTOR(4 downto 0));
end component;

component translate_count is
port ( x : in std_logic_vector(5 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;

begin

reset <= not reset_n;
enable <= "11111111";

cronometro : orologio port map(
    -- il preset hardcoded e' 11h, 17m e 50s
    clock => clock, reset => reset, preset => preset, set_s => "110010", set_m => "010001", set_h => "01011", s => u_s,
    m => u_m, h => u_h(4 downto 0)
);

translate_s : translate_count port map(
    x => u_s, y => value(7 downto 0)
);

translate_m : translate_count port map(
    x => u_m, y => value(15 downto 8)
);

translate_h : translate_count port map(
    x => u_h, y => value(23 downto 16)
);

value(31 downto 24) <= (others => '0');

end Structural;

