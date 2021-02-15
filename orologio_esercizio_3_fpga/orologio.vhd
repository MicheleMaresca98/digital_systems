----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:17:05 11/08/2020 
-- Design Name: 
-- Module Name:    orologio - Behavioral 
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

entity orologio is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           preset : in  STD_LOGIC;
           set_s : in  STD_LOGIC_VECTOR(5 downto 0);
           set_m : in  STD_LOGIC_VECTOR(5 downto 0);
           set_h : in  STD_LOGIC_VECTOR(4 downto 0);
           s : out  STD_LOGIC_VECTOR(5 downto 0);
           m : out  STD_LOGIC_VECTOR(5 downto 0);
           h : out  STD_LOGIC_VECTOR(4 downto 0));
end orologio;

architecture Structural of orologio is
-- segnali interni
signal clock_sec : std_logic := '0';
signal clock_min : std_logic := '0';
signal clock_h : std_logic := '0';
signal reset_n : std_logic := '1';

-- dispositivi interni
component contatore_mod_M is
	 Generic (n_bit : positive := 3; M : std_logic_vector := "111");
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           par : in  STD_LOGIC_VECTOR(n_bit-1 downto 0);
           preset : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(n_bit-1 downto 0);
			  overflow : out STD_LOGIC);
end component;

component clock_filter is
	 generic(
				clock_frequency_in : integer := 50000000;
				clock_frequency_out : integer := 5000000
				);
    Port ( clock_in : in  STD_LOGIC;
				reset_n : in STD_LOGIC;
           clock_out : out  STD_LOGIC);
end component;

begin

reset_n <= not reset;

prescaler : clock_filter generic map(clock_frequency_in => 100000000, clock_frequency_out => 1) port map(
	clock_in => clock, reset_n => reset_n, clock_out => clock_sec
);
-- 0111100 = 60 in decimale
cont_sec : contatore_mod_M generic map(n_bit => 6, M => "111011") port map(
	clock => clock_sec, reset => reset, par => set_s, preset => preset, overflow => clock_min,
	y => s
);
cont_min : contatore_mod_M generic map(n_bit => 6, M => "111011") port map(
	clock => clock_min, reset => reset, par => set_m, preset => preset, overflow => clock_h,
	y => m
);
-- 11000 = 24 in decimale
cont_h : contatore_mod_M generic map(n_bit => 5, M => "10111") port map(
	clock => clock_h, reset => reset, par => set_h, preset => preset, y => h
);

end Structural;

