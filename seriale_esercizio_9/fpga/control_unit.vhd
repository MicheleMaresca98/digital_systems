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
		   wr : in  STD_LOGIC;
		   dbin : in STD_LOGIC_VECTOR(7 downto 0);
           value : out  STD_LOGIC_VECTOR(31 downto 0);
           enable : out  STD_LOGIC_VECTOR(7 downto 0);
           rda : inout STD_LOGIC;
           rd : in STD_LOGIC
			  );
end control_unit;

architecture tappo of control_unit is

signal reset : std_logic;
signal dbout : std_logic_vector(7 downto 0);

component uart_tappo is		
	Port(
    	CLK 	: in  std_logic;								--Master Clock
		DBIN 	: in  std_logic_vector (7 downto 0);	--Data Bus in
		DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
		RST		: in  std_logic	:= '0';	--Master Reset
		WR		: in  std_logic;					--Write Strobe(se  1 significa "scrivi")
		RDA	: inout std_logic;	--Read Data Available( alto quando il dato  disponibile nel registro rdReg)
		RD : in std_logic
	);
end component;

begin

reset <= not reset_n;
enable <= "00000011";
value(31 downto 8) <= (others => '0');
value(7 downto 0) <= dbout;

seriale : uart_tappo port map(
    CLK => clock, DBIN => dbin, DBOUT => dbout, RST => reset, WR => wr, RDA => rda, RD => rd
);

end tappo;


architecture due_seriali of control_unit is

signal reset : std_logic;
signal dbout : std_logic_vector(7 downto 0);

component uart_2 is		
	Port(
    	CLK 	: in  std_logic;								--Master Clock
		DBIN 	: in  std_logic_vector (7 downto 0);	--Data Bus in
		DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
		RST		: in  std_logic	:= '0';	--Master Reset
		WR		: in  std_logic;					--Write Strobe(se  1 significa "scrivi")
		RDA	: inout std_logic;	--Read Data Available( alto quando il dato  disponibile nel registro rdReg)
		RD : in std_logic
	);
end component;

begin

reset <= not reset_n;
enable <= "00000011";
value(31 downto 8) <= (others => '0');
value(7 downto 0) <= dbout;

seriale : uart_2 port map(
    CLK => clock, DBIN => dbin, DBOUT => dbout, RST => reset, WR => wr, RDA => rda, RD => RD
);

end due_seriali;

