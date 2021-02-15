----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:37:57 10/15/2020 
-- Design Name: 
-- Module Name:    decoder_2_4 - Behavioral 
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

entity decoder_2_4 is
    Port ( x1 : in  STD_LOGIC;
           x0 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           yv : out  STD_LOGIC_VECTOR(3 downto 0));
end decoder_2_4;

architecture Structural of decoder_2_4 is
-- segnali interni
	signal u0 : STD_LOGIC := '0';
	signal u1 : STD_LOGIC := '0';
-- dispositivi interni
	component decoder_1_2
	port(
		x : in  STD_LOGIC;
      s : in  STD_LOGIC;
      y0 : out  STD_LOGIC;
		y1 : out  STD_LOGIC
	);
	end component;

begin
	dec_first: decoder_1_2
	Port map(
		x => x1,
		s => s0,
		y0 => u0,
		y1 => u1
	);
	
	dec0: decoder_1_2
	Port map(
		x => x0,
		s => u0,
		y0 => yv(0),
		y1 => yv(1)
	);

	dec1: decoder_1_2
	Port map(
		x => x0,
		s => u1,
		y0 => yv(2),
		y1 => yv(3)
	);

end Structural;

