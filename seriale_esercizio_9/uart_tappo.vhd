----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:59:00 12/30/2020 
-- Design Name: 
-- Module Name:    uart_tappo - Behavioral 
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

entity uart_tappo is		
	Port(
    	CLK 	: in  std_logic;								--Master Clock
		DBIN 	: in  std_logic_vector (7 downto 0);	--Data Bus in
		DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
		RST		: in  std_logic	:= '0';	--Master Reset
		WR		: in  std_logic;					--Write Strobe(se  1 significa "scrivi")
		RD : in std_logic;
		RDA	: inout std_logic	--Read Data Available( alto quando il dato  disponibile nel registro rdReg)
	);
end uart_tappo;

architecture Behavioral of uart_tappo is

signal tx, rx : std_logic;
-- signal rd : std_logic := '0'; -- serve per abilitare la diagnostica

component tappo is
    Port ( x : in  STD_LOGIC;
           y : out  STD_LOGIC);
end component;

component Rs232RefComp is
    Port ( 
		TXD 	: out std_logic  	:= '1';
    	RXD 	: in  std_logic;					
    	CLK 	: in  std_logic;								--Master Clock
		DBIN 	: in  std_logic_vector (7 downto 0);	--Data Bus in
		DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
		RDA	: inout std_logic;						--Read Data Available( alto quando il dato  disponibile nel registro rdReg)
		TBE	: inout std_logic 	:= '1';			--Transfer Bus Empty(se  0 significa che il bus  occupato per una trasmissione)
		RD		: in  std_logic;					--Read Strobe(se  0 significa "leggi")
		WR		: in  std_logic;					--Write Strobe(se  1 significa "scrivi")
		PE		: out std_logic;					--Parity Error Flag
		FE		: out std_logic;					--Frame Error Flag
		OE		: out std_logic;					--Overwrite Error Flag
		RST		: in  std_logic	:= '0');	--Master Reset
end component;

begin

seriale : Rs232RefComp port map(
	CLK => CLK, RST => RST, DBIN => DBIN, WR => WR, DBOUT => DBOUT,
	TXD => tx, RXD => rx, RD => RD, RDA => RDA
);

feedback : tappo port map(
	x => tx, y => rx
);

end Behavioral;

