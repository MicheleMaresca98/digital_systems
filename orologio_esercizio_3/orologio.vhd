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
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           set : in  STD_LOGIC;
           set_s : in  STD_LOGIC_VECTOR(5 downto 0);
           set_m : in  STD_LOGIC_VECTOR(5 downto 0);
           set_h : in  STD_LOGIC_VECTOR(4 downto 0);
           s : out  STD_LOGIC_VECTOR(5 downto 0);
           m : out  STD_LOGIC_VECTOR(5 downto 0);
           h : out  STD_LOGIC_VECTOR(4 downto 0));
end orologio;

architecture Structural of orologio is
-- costanti: frequenza del clock 50 MHz
--constant n : positive := 26;
--constant m_psc : std_logic_vector(n-1 downto 0) := "10111110101111000010000000";
 -- per simulare:
constant n : positive := 3;
constant m_psc : std_logic_vector(n-1 downto 0) := "101";
-- segnali interni
signal clk_sec : std_logic := '0';
signal clk_min : std_logic := '0';
signal clk_h : std_logic := '0';
-- mi serve un segnale zero perché non posso mettere (others => '0') nel port map
signal zero : std_logic_vector(n-1 downto 0) := (others => '0');
-- dispositivi interni
component contatore_mod_M is
	 Generic (n_bit : positive := 3; M : std_logic_vector := "111");
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           par : in  STD_LOGIC_VECTOR(n_bit-1 downto 0);
           set : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(n_bit-1 downto 0);
			  overflow : out STD_LOGIC);
end component;

begin
prescaler : contatore_mod_M generic map(n_bit => n, M => m_psc) port map(
	clk => clk, rst => rst, par => zero, set => set, overflow => clk_sec
);
-- 0111100 = 60 in decimale
cont_sec : contatore_mod_M generic map(n_bit => 6, M => "111100") port map(
	clk => clk_sec, rst => rst, par => set_s, set => set, overflow => clk_min,
	y => s
);
cont_min : contatore_mod_M generic map(n_bit => 6, M => "111100") port map(
	clk => clk_min, rst => rst, par => set_m, set => set, overflow => clk_h,
	y => m
);
-- 11000 = 24 in decimale
cont_h : contatore_mod_M generic map(n_bit => 5, M => "11000") port map(
	clk => clk_h, rst => rst, par => set_h, set => set, y => h
);

end Structural;

