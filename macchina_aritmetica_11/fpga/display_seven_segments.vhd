----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:48:25 09/16/2012 
-- Design Name: 
-- Module Name:    display_seven_segments - Behavioral 
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

entity display_seven_segments is
	Generic( 
				clock_frequency_in : integer := 50000000; --parametri da customizzare, questo � il valore di default
				clock_frequency_out : integer := 5000000
				);
    Port ( clock : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           value : in  STD_LOGIC_VECTOR (31 downto 0);
           enable : in  STD_LOGIC_VECTOR (7 downto 0);
           dots : in  STD_LOGIC_VECTOR (7 downto 0);
           anodes : out  STD_LOGIC_VECTOR (7 downto 0);
           cathodes : out  STD_LOGIC_VECTOR (7 downto 0));
end display_seven_segments;

architecture Structural of display_seven_segments is

signal counter : std_logic_vector(2 downto 0);
signal clock_fx : std_logic := '0';

COMPONENT counter_mod4
	PORT(
		clock : in  STD_LOGIC;
      reset_n : in  STD_LOGIC;
		enable : in STD_LOGIC;
      counter : out  STD_LOGIC_VECTOR (2 downto 0)
		);
END COMPONENT;

COMPONENT cathodes_manager
	PORT(
		counter : IN std_logic_vector(2 downto 0);
		value : IN std_logic_vector(31 downto 0);
		dots : IN std_logic_vector(7 downto 0);          
		cathodes : OUT std_logic_vector(7 downto 0)
		);
END COMPONENT;

COMPONENT anodes_manager
	PORT(

		counter : IN std_logic_vector(2 downto 0);
		enable_digit : IN std_logic_vector(7 downto 0);          
		anodes : OUT std_logic_vector(7 downto 0)
		);
END COMPONENT;

COMPONENT clock_filter
	GENERIC(
				clock_frequency_in : integer := 50000000;
				clock_frequency_out : integer := 5000000
				);
	PORT(
		clock_in : IN std_logic; 
        reset_n : in  STD_LOGIC;		
		clock_out : OUT std_logic
		);
END COMPONENT;
begin
--il clock filter genera un segnale di abilitazione per il contatore mod4 che viene usato
--come segnale di conteggio e quindi di fatto fornisce la frequenza con cui viene modificata
--la cifra da mostrare

clk_filter: clock_filter GENERIC MAP(
	clock_frequency_in => clock_frequency_in,
	clock_frequency_out => clock_frequency_out
	)
	PORT MAP(
		clock_in => clock,
		reset_n => reset_n,
		clock_out => clock_fx
	);

counter_instance: counter_mod4 port map(
	clock => clock,
	enable => clock_fx,
	reset_n => reset_n,
	counter => counter
);
--il valore di conteggio viene usato dal gestore dei catodi e degli anodi per
--selezionare l'anodo da accendere e il suo rispettivo valore
cathodes_instance: cathodes_manager port map(
	counter => counter,
	value => value,
	dots => dots,
	cathodes => cathodes
);

anodes_instance: anodes_manager port map(
	counter => counter,
	enable_digit => enable,
	anodes => anodes
);


end Structural;

