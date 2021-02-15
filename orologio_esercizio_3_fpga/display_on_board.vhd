----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:08:44 10/23/2012 
-- Design Name: 
-- Module Name:    display_on_board - Behavioral 
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


entity display_on_board is
	Port(
		  clock : in  STD_LOGIC;
		  reset : in  STD_LOGIC;
		  preset : in STD_LOGIC;
		  anodes : out  STD_LOGIC_VECTOR (7 downto 0); --anodi e catodi delle cifre
		  cathodes : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end display_on_board;

architecture Structural of display_on_board is

COMPONENT display_seven_segments
	GENERIC(
				clock_frequency_in : integer := 50000000; --questi parametri servono a configurare
				clock_frequency_out : integer := 5000000  --il clock filter
				);
	PORT(
		clock : IN std_logic;
		reset_n : IN std_logic;
		value : IN std_logic_vector(31 downto 0);--6 nibble da mostrare
		enable : IN std_logic_vector(7 downto 0);--abilitazione delle 4 cifre
		dots : IN std_logic_vector(7 downto 0); --punti        
		anodes : OUT std_logic_vector(7 downto 0);
		cathodes : OUT std_logic_vector(7 downto 0)
		);
END COMPONENT;

component control_unit is
    Port ( 
		   clock : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
		   preset : in  STD_LOGIC;
           value : out  STD_LOGIC_VECTOR(31 downto 0);
           enable : out  STD_LOGIC_VECTOR(7 downto 0)
			  );
end component;

signal reset_n : std_logic;
signal cu_value : std_logic_vector(31 downto 0);
signal cu_enable : std_logic_vector(7 downto 0);
signal cu_dots : std_logic_vector(7 downto 0) := (others => '0');

begin

reset_n <= not reset;

seven_segment_array: display_seven_segments GENERIC MAP(
	clock_frequency_in => 50000000, --qui inserisco i parametri effettivi (clock della board e clock in uscita desiderato)
	clock_frequency_out => 50000
	)
	PORT MAP(
		clock => clock,
		reset_n => reset_n,
		value => cu_value,
		enable => cu_enable,
		dots => cu_dots,
		anodes => anodes,
		cathodes => cathodes
);

cu: control_unit PORT MAP(
		clock => clock,
		reset_n => reset_n,
		preset => preset,
		value => cu_value,
		enable => cu_enable
	);

end Structural;

