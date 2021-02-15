----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:39:27 10/15/2020 
-- Design Name: 
-- Module Name:    decoder_4_16 - Behavioral 
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


entity decoder_4_16 is
    Port ( x : in  STD_LOGIC_VECTOR(3 downto 0);
           s : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(15 downto 0));
end decoder_4_16;

architecture Tree of decoder_4_16 is
-- segnali interni
	signal u : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
-- dispositivi interni
	component decoder_2_4
	port (
			  x1 : in  STD_LOGIC;
           x0 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           yv : out  STD_LOGIC_VECTOR(3 downto 0));
	end component;

begin
	dec_first: decoder_2_4
	Port map(
		x1 => x(3),
		x0 => x(2),
		s0 => s,
		yv => u
	);
	
	dec0: decoder_2_4
	Port map(
		x1 => x(1),
		x0 => x(0),
		s0 => u(0),
		yv => y(3 downto 0)
	);

	dec1: decoder_2_4
	Port map(
		x1 => x(1),
		x0 => x(0),
		s0 => u(1),
		yv => y(7 downto 4)
	);
	
	dec2: decoder_2_4
	Port map(
		x1 => x(1),
		x0 => x(0),
		s0 => u(2),
		yv => y(11 downto 8)
	);
	
	dec3: decoder_2_4
	Port map(
		x1 => x(1),
		x0 => x(0),
		s0 => u(3),
		yv => y(15 downto 12)
	);

end Tree;


Architecture SemiSel of decoder_4_16 is
-- segnali interni
signal u1 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal u2 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
-- dispositivi interni
component decoder_2_4
	port (
			  x1 : in  STD_LOGIC;
           x0 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           yv : out  STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
component logic_and
	port (a : in STD_LOGIC; b : in STD_LOGIC; y: out STD_LOGIC);
end component;

begin
	dec1 : decoder_2_4 port map(
		x1 => x(3), x0 => x(2), s0 => s, yv => u1
	);
	dec2 : decoder_2_4 port map(
		x1 => x(1), x0 => x(0), s0 => s, yv => u2
	);
	-- u2 deve stare nel for più annidato del generate
	and_u1 : for i in 0 to 3 generate
		and_u2 : for j in 0 to 3 generate
			bit_out : logic_and port map(
				a => u2(j), b => u1(i), y => y(j + i*4)
			);
		end generate;
	end generate;

end SemiSel;



