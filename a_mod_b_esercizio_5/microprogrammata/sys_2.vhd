----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:57:21 11/20/2020 
-- Design Name: 
-- Module Name:    system - Behavioral 
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

entity system is
	PORT (
		buff_in : in std_logic_vector ( 7 downto 0 );
		buff_out : out std_logic_vector ( 7 downto 0 );
		clk : in std_logic;
		start : in std_logic;
		syn_out : out std_logic;
		ack_out : out std_logic;
		syn_in : in std_logic;
		ack_in : in std_logic;
		EOOP : out std_logic
		);
end system;

architecture Behavioral of system is
	component FF_D is
		port (
			clk, en, reset : in std_logic;
			D : in std_logic_vector ( 7 downto 0 );
			Q : out std_logic_vector ( 7 downto 0 ));
	end component;
	
	component U_O is
		PORT ( 
			busin : in std_logic_vector ( 7 downto 0 );
			clk, enA, enB, selB, selA, start : in std_logic;
			busout : out std_logic_vector ( 7 downto 0 );
			cout : out std_logic
			);
	end component;
	
		component A_B is
			port(
				clk : in std_logic;
				buff_out_in : in std_logic_vector(7 downto 0);
				buff_in_out : in std_logic_vector(7 downto 0);
				to_in : out std_logic_vector(7 downto 0);
				to_out : out std_logic_vector(7 downto 0);
				start : in std_logic;
				syn_out : out std_logic;
				ack_in : in std_logic;
				syn_in : in std_logic;
				ack_out : out std_logic;
				EOOP_in : in std_logic;
				EOOP_out : out std_logic;
				ready : out std_logic);
	end component;
	
	component U_C is
		PORT (
			ready : IN std_logic;
			clk : IN std_logic;
			start : IN std_logic;
			cout : IN std_logic;
			selA : OUT std_logic;
			enA : OUT std_logic;
			selB : OUT std_logic;
			enB : OUT std_logic;
			EOOP : OUT std_logic
		);
	end component;

signal buff : std_logic_vector( 7 downto 0 ) := (others => '0');
signal buffout : std_logic_vector( 7 downto 0 ) := (others => '0');
signal ready : std_logic := '0';
signal cout : std_logic := '0';
signal selA : std_logic := '0';
signal enA : std_logic := '0';
signal selB : std_logic := '0';
signal enB : std_logic := '0';
signal enRC : std_logic := '0';
signal EOOP_internal : std_logic := '0';
signal result : std_logic_vector( 7 downto 0 ) := (others => '0');

begin

U_O_S_2 : U_O
	port map(
			busin => buff,
			clk => clk,
			enA => enA,
			enB => enB,
			selB => selB,
			selA => selA,
			start => start,
			busout => result,
			cout => cout
			);
			
U_C_S_2 : U_C
	port map(
	
		ready => ready,
		clk => clk,
		start => start,
		cout => cout,
		selA => selA,
		enA => enA,
		selB => selB,
		enB => enB,
		EOOP => EOOP_internal
		
		);
		
A_B_S_2 : A_B
	port map(
			clk => clk,
			buff_out_in => buff_in,
			buff_in_out => result,
			to_in => buff,
			to_out => buff_out,
			start => start,
			ack_in => ack_in,
			syn_in => syn_in,
			ack_out => ack_out,
			syn_out => syn_out,
			EOOP_in => EOOP_internal,
			EOOP_out => EOOP,
			ready => ready
		);



end Behavioral;

