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
		  start : in  STD_LOGIC;
		  A : in STD_LOGIC_VECTOR(7 downto 0);
		  B : in STD_LOGIC_VECTOR(7 downto 0);
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

component ctrl_unit is
    Port ( 
		   clock : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
		   start : in  STD_LOGIC;
		   A : in STD_LOGIC_VECTOR(7 downto 0);
		   B : in STD_LOGIC_VECTOR(7 downto 0);
           value : out  STD_LOGIC_VECTOR(31 downto 0);
           enable : out  STD_LOGIC_VECTOR(7 downto 0)
			  );
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

signal reset_n : std_logic;
signal cu_value : std_logic_vector(31 downto 0);
signal cu_enable : std_logic_vector(7 downto 0);
signal cu_dots : std_logic_vector(7 downto 0) := (others => '0');
signal clk_moltiplicatore : std_logic;
signal actual_start : std_logic := '0';

begin

reset_n <= not reset;

client_protocol : process(clk_moltiplicatore)
begin
    if (clk_moltiplicatore'event and clk_moltiplicatore = '1') then
        if actual_start = '1' then
            actual_start <= '0';
        else
            actual_start <= start;
        end if;
    end if; 
end process;

clk_filter : clock_filter GENERIC MAP(clock_frequency_in => 100000000, clock_frequency_out => 10000000)
    PORT MAP( clock_in => clock, reset_n => reset_n, clock_out => clk_moltiplicatore);

seven_segment_array: display_seven_segments GENERIC MAP(
	clock_frequency_in => 100000000, --qui inserisco i parametri effettivi (clock della board e clock in uscita desiderato)
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

cu: ctrl_unit PORT MAP(
		clock => clk_moltiplicatore,
		reset_n => reset_n,
		start => actual_start,
		A => A,
		B => B,
		value => cu_value,
		enable => cu_enable
	);

end Structural;

