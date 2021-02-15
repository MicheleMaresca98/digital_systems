----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:23:23 11/07/2020 
-- Design Name: 
-- Module Name:    contatore_N_bit - Behavioral 
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

entity contatore_N_bit is
	 Generic (n : positive := 3);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           par : in  STD_LOGIC_VECTOR(n-1 downto 0);
           preset : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(n-1 downto 0));
end contatore_N_bit;

architecture Structural of contatore_N_bit is
-- segnali interni
-- signal u_clock : STD_LOGIC_VECTOR(n-2 downto 0); -- serviva per lo schema parallelo
signal y_tmp : STD_LOGIC_VECTOR(n-1 downto 0);
signal front_y : STD_LOGIC := '0';
-- dispositivi interni
component flip_flop_T is
    Port ( t : in  STD_LOGIC;
           clock : in  STD_LOGIC;
			  preset : in STD_LOGIC;
			  d : in STD_LOGIC;
           reset : in  STD_LOGIC;
           q : out  STD_LOGIC);
end component;

component logic_and is
	 Generic ( n : positive := 2 );
    Port ( a : in  STD_LOGIC_VECTOR(n-1 downto 0);
           y : out  STD_LOGIC);
end component;

begin
front_y <= clock or reset;

frontend : flip_flop_T Port map(
	t => '1', clock => front_y, preset => preset, d => par(0), reset => reset, q => y_tmp(0)
);
inner : for i in 1 to n-1 generate
	-- per lo schema parallelo, dà problemi di compilazione
--	new_clock : logic_and generic map(i+1) Port map(
--		a(0) => clock, a(1 to i) => y_tmp(0 to (i-1)), y => u_clock(i-1)
--	);
--	ff_t : flip_flop_T Port map(
--		t => '1', clock => u_clock(i-1), preset => preset, d => par(i), reset => reset, q => y_tmp(i)
--	);
	ff_t : flip_flop_T Port map(
		t => '1', clock => y_tmp(i-1), preset => preset, d => par(i), reset => reset, q => y_tmp(i)
	);
end generate;

y <= y_tmp;

end Structural;

