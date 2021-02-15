----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:36:24 11/18/2020 
-- Design Name: 
-- Module Name:    U_O - Behavioral 
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

entity U_O is

	port(
		busin : in std_logic_vector ( 7 downto 0 );
		clk, enA, enB, selB, selA, start : in std_logic;
		busout : out std_logic_vector ( 7 downto 0 );
		cout : out std_logic
		);
end U_O; 

architecture Behavioral of U_O is

component Ripple_Carry is

    Port ( x : in  STD_LOGIC_VECTOR(7 downto 0);
           y : in  STD_LOGIC_VECTOR(7 downto 0);
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR(7 downto 0);
           Cout : out  STD_LOGIC);
			  
end component;

component FF_D is
port (
	clk, en, reset : in std_logic;
	D : in std_logic_vector ( 7 downto 0 );
	Q : out std_logic_vector ( 7 downto 0 ));
end component;
component mux2_1 is

    Port ( I0 : in STD_LOGIC_VECTOR(7 downto 0);
			  I1 : in STD_LOGIC_VECTOR(7 downto 0);
           S : in  STD_LOGIC;
           U : out STD_LOGIC_VECTOR(7 downto 0)
			 );
end component;

signal a_mux : STD_LOGIC_VECTOR(7 downto 0);
signal b_mux : STD_LOGIC_VECTOR(7 downto 0);
signal a_ff : STD_LOGIC_VECTOR(7 downto 0);
signal b_ff : STD_LOGIC_VECTOR(7 downto 0);
signal a_feedback : STD_LOGIC_VECTOR(7 downto 0);
signal Cout_interno : std_logic := '0';

begin

muxa : mux2_1
	port map(
		I0 => a_feedback,
		I1 => busin,
		S => selA,
		U => a_mux
		);

muxb : mux2_1
	port map(
		I0 => "00000000",
		I1 => busin,
		S => selB,
		U => b_mux
		);
		
ff_a : FF_D
	port map(
		clk => clk,
		en => (enA and Cout_interno),
		reset => start,
		D => a_mux,
		Q => a_ff
		);
		
ff_b : FF_D
	port map(
		clk => clk,
		en => enb,
		reset => start,
		D => b_mux,
		Q => b_ff
		);

sottrattore : Ripple_Carry
	port map(
		x => a_ff,
		y => not(b_ff),
		cin => '1',
		Sum => a_feedback,
		cout => Cout_interno
		);
	
cout <= Cout_interno;

busout <= a_feedback;


end Behavioral;

