----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:16:16 11/21/2020 
-- Design Name: 
-- Module Name:    ProdScal - Structural 
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

entity ProdScal is
    Port ( CLK : in  STD_LOGIC;
           START : in  STD_LOGIC;
           AB : out  STD_LOGIC_VECTOR(15 downto 0));
end ProdScal;

architecture Structural of ProdScal is

signal EN : std_logic:='0';
signal RESET : std_logic:='0';

signal A : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal B : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

signal abilitazione_risultato : std_logic:='0';
signal reset_risultato : std_logic:='0';


Component unita_operativa is
		Port ( CLK : in  STD_LOGIC;
					EN : in  STD_LOGIC;
				RESET : in STD_LOGIC;
				A : in  STD_LOGIC_VECTOR(7 downto 0);
           B : in  STD_LOGIC_VECTOR(7 downto 0);
				AB : out STD_LOGIC_VECTOR(15 downto 0);
			 abilitazione_risultato : in std_logic;
			 reset_risultato : in std_logic
	);
end component;
	Component unita_controllo is
		Port ( CLK : in  STD_LOGIC;
           START : in  STD_LOGIC;
	EN : out  STD_LOGIC;
	RESET : out STD_LOGIC;
           A : out  STD_LOGIC_VECTOR(7 downto 0);
           B : out  STD_LOGIC_VECTOR(7 downto 0);
			  abilitazione_risultato : out std_logic;
			  reset_risultato : out std_logic

	);
	end component;
begin
	U_O: unita_operativa
	Port map(CLK=>CLK,EN=>EN,RESET=>RESET,A=>A,B=>B,AB=>AB, abilitazione_risultato => abilitazione_risultato, reset_risultato=>reset_risultato);
	
	U_C: unita_controllo
	Port map(CLK=>CLK,START=>START,EN=>EN,RESET=>RESET,A=>A,B=>B, abilitazione_risultato=>abilitazione_risultato,reset_risultato=>reset_risultato);

end Structural;

