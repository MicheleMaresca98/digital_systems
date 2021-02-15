----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:16:15 11/07/2020 
-- Design Name: 
-- Module Name:    contatore_mod_M - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contatore_mod_M is
	 -- M dovrebbe essere n_bit downto 0, ma deve rimanere unconstrained altrimenti
	 -- dà errore a tempo di compilazione; NOTA: M è inclusivo, ovvero in realtà
	 -- conta mod(M + 1)
	 Generic (n_bit : positive := 3; M : std_logic_vector := "111");
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           par : in  STD_LOGIC_VECTOR(n_bit-1 downto 0);
           preset : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(n_bit-1 downto 0);
		   overflow : out STD_LOGIC);
end contatore_mod_M;

architecture Hybrid of contatore_mod_M is
signal y_tmp : std_logic_vector(n_bit-1 downto 0) := (others => '0');
signal reset_overflow : std_logic := '0';
signal u_reset : std_logic := '0';

component contatore_N_bit is
	 Generic (n : positive := 3);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           par : in  STD_LOGIC_VECTOR(n-1 downto 0);
           preset : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

component comparator is
	 Generic (n : positive := 2);
    Port ( a : in  STD_LOGIC_VECTOR(n-1 downto 0);
           b : in  STD_LOGIC_VECTOR(n-1 downto 0);
			  clock : in STD_LOGIC;
           y : out  STD_LOGIC);
end component;

begin
contatore : contatore_N_bit generic map(n_bit) port map(
	clock => clock, reset => u_reset, par => par, preset => preset, y => y_tmp
);

feedback : comparator generic map(n_bit) port map(
	a => M, b => y_tmp, clock => clock, y => reset_overflow
);

propagation : comparator generic map(n_bit) port map(
	a => std_logic_vector(to_unsigned(to_integer(unsigned(M))-1, n_bit)), b => y_tmp, clock => clock, y => overflow
);

mux_reset : process(reset, reset_overflow)
begin
	if (reset = '1') then
		u_reset <= '1';
	else
		u_reset <= reset_overflow;
	end if;
end process;

y <= y_tmp;

end Hybrid;

