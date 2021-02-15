----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:31:32 12/30/2020 
-- Design Name: 
-- Module Name:    uart_2 - Behavioral 
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

entity uart_2 is
	Port(
    	CLK 	: in  std_logic;								--Master Clock
		DBIN 	: in  std_logic_vector (7 downto 0);	--Data Bus in
		DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
		RST		: in  std_logic	:= '0';	--Master Reset
		WR		: in  std_logic;				--Write Strobe(se  1 significa "scrivi")
		RD : in std_logic;
		RDA	: inout std_logic
	);
end uart_2;

architecture Behavioral of uart_2 is

signal tx : std_logic := '1';

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

seriale_1 : Rs232RefComp port map(
	CLK => CLK, RST => RST, DBIN => DBIN, WR => WR,
	TXD => tx, RXD => '1', RD => '1'
);

seriale_2 : Rs232RefComp port map(
	CLK => CLK, RST => RST, WR => '0', RDA => RDA, DBIN => "00000000",
	RXD => tx, RD => RD, DBOUT => DBOUT
);

end Behavioral;

