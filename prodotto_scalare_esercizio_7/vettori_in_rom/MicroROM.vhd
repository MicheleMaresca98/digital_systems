----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:13:23 11/21/2020 
-- Design Name: 
-- Module Name:    MicroROM - Behavioral 
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

use IEEE.std_logic_arith.all;
use work.all;


entity MicroROM is
    Port ( PC : in  unsigned(3 downto 0);
           PC_next : out  unsigned(3 downto 0);
           A : out  STD_LOGIC_VECTOR(7 downto 0);
           B : out  STD_LOGIC_VECTOR(7 downto 0);
           EN : out  STD_LOGIC;
           RESET : out  STD_LOGIC
	);
end MicroROM;

architecture synth of MicroROM is

	type Controllo_type is record
		PC_next	: unsigned(3 downto 0);
		A		: std_logic_vector(7 downto 0);
		B		: std_logic_vector(7 downto 0);
		EN		: std_logic;
		RESET		:std_logic;
	end record;
	
	constant idle : Controllo_type := (
		PC_next => "0000",
		A  => "00000000",
		B	=> "00000000",
		EN	=> '0',
		RESET	=> '1'
		);
	constant k00 : Controllo_type := (
		PC_next => "0010",
		A => "00000011",
		B	=> "00000101",
		EN	=> '1',
		RESET	=> '0'
		);
	constant k01 : Controllo_type := (
		PC_next => "0011",
		A => "00000010",
		B	=> "00000110",
		EN	=> '1',
		RESET	=> '0'
		);
	constant k02 : Controllo_type := (
		PC_next => "0100",
		A => "00000001",
		B	=> "00000011",
		EN	=> '1',
		RESET	=> '0'
		);
	constant k10 : Controllo_type := (
		PC_next => "0101",
		A  => "00000100",
		B	=> "00000110",
		EN	=> '1',
		RESET	=> '0'
		);
	constant k11 : Controllo_type := (
		PC_next => "0110",
		A  => "00000011",
		B	=> "00000111",
		EN	=> '1',
		RESET	=> '0'
		);
	constant k12 : Controllo_type := (
		PC_next => "0111",
		A  => "00000010",
		B	=> "00000100",
		EN	=> '1',
		RESET	=> '0'
		);
	constant k20 : Controllo_type := (
		PC_next => "1000",
		A => "00000101",
		B	=> "00000111",
		EN	=> '1',
		RESET	=> '0'
		);
	constant k21 : Controllo_type := (
		PC_next => "1001",
		A  => "00000001",
		B	=> "00001000",
		EN	=> '1',
		RESET	=> '0'
		);
	constant k22 : Controllo_type := (
		PC_next => "0000",
		A  => "00000101",
		B	=> "00000011",
		EN	=> '1',
		RESET	=> '0'
		);
	
		
	type ROM_TYPE is ARRAY(0 to 9) of Controllo_type;
	
	constant ROM : ROM_TYPE := (
		0 => idle,
		1 => k00,
		2 => k01,
		3 => k02,
		4 => k10,
		5 => k11,
		6 => k12,
		7 => k20,
		8 => k21,
		9 => k22
		);
		
		signal Controllo : Controllo_type;
		
begin
	
		Controllo <= ROM(conv_integer(PC));
		
		PC_next <= Controllo.PC_next;
		A		<= Controllo.A;
		B		<= Controllo.B;
		EN		<= Controllo.EN;
		RESET		<= Controllo.RESET;

end synth;


