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
use work.all;

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
		  wr : in  STD_LOGIC;
		  dbin : in STD_LOGIC_VECTOR(7 downto 0);
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
		   wr : in  STD_LOGIC;
		   dbin : in STD_LOGIC_VECTOR(7 downto 0);
           value : out  STD_LOGIC_VECTOR(31 downto 0);
           enable : out  STD_LOGIC_VECTOR(7 downto 0);
           rda : out STD_LOGIC
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
signal clk_seriale : std_logic;
signal actual_wr : std_logic;
signal rda : std_logic;
signal rd : std_logic := '0';

begin

reset_n <= not reset;

client_protocol : process(clk_seriale)
begin
    if (clk_seriale'event and clk_seriale = '1') then
        rd <= rda;
        if rda = '1' then
            actual_wr <= '0';
        else
            actual_wr <= wr;
        end if;
    end if; 
end process;

clk_filter : clock_filter GENERIC MAP(clock_frequency_in => 100000000, clock_frequency_out => 10000000)
    PORT MAP( clock_in => clock, reset_n => reset_n, clock_out => clk_seriale);

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

cu: entity work.control_unit(due_seriali) PORT MAP(
		clock => clk_seriale,
		reset_n => reset_n,
		wr => actual_wr,
		dbin => dbin,
		value => cu_value,
		enable => cu_enable,
		rda => rda,
		rd => rd
	);

end Structural;

