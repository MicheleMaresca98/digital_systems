----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:09:06 11/17/2020 
-- Design Name: 
-- Module Name:    ROM - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
Port ( 
		PC : IN unsigned (2 downto 0);
		PC_next : OUT unsigned (2 downto 0);
		jcout : OUT std_logic;
		selA : OUT std_logic;
		enA : OUT std_logic;
		selB : OUT std_logic;
		enB : OUT std_logic;
		EOOP : OUT std_logic
		);
end ROM;

architecture Behavioral of ROM is

	type control_record is record
		PC_next : unsigned (2 downto 0);
		jcout : std_logic;
		selA : std_logic;
		enA : std_logic;
		selB : std_logic;
		enB : std_logic;
		EOOP : std_logic;
	end record;


	constant idle : control_record := (
					PC_next => "001",
					jcout => '0',
					selA => '0',
					enA => '0', 
					selB => '0',
					enB => '1', 
					EOOP => '0'
					);

	constant getA : control_record := (
					PC_next => "010",
					jcout => '0',
					selA => '1',
					enA => '1', 
					selB => '0',
					enB => '0', 
					EOOP => '0'
					);
	constant prepareB : control_record := (
					PC_next => "011",
					jcout => '0',
					selA => '0',
					enA => '0', 
					selB => '1',
					enB => '0', 
					EOOP => '0'
					);				
	constant getB : control_record := (
					PC_next => "100",
					jcout => '0',
					selA => '0',
					enA => '0', 
					selB => '1',
					enB => '1', 
					EOOP => '0'
					);
					
	constant op : control_record := (
					PC_next => "100",
					jcout => '1',
					selA => '0',
					enA => '1', 
					selB => '0',
					enB => '0', 
					EOOP => '0'
					);

	constant end_op : control_record := (
					PC_next => "000",
					jcout => '0',
					selA => '0',
					enA => '0', 
					selB => '0',
					enB => '1', 
					EOOP => '1'
					);
	
	type ROM_TYPE is array ( 0 to 5 ) of control_record;
	
	constant control_store : ROM_TYPE := (
						0 => idle,
						1 => getA,
						2 => prepareB,
						3 => getB,
						4 => op,
						5 => end_op
	);
	
	signal controllo : control_record;
	
begin

	controllo <= control_store(to_integer(PC));
	
	PC_next <= controllo.PC_next;
	jcout <= controllo.jcout;
	selA <= controllo.selA;
	enA <= controllo.enA; 
	selB <= controllo.selB;
	enB <= controllo.enB; 
	EOOP <= controllo.EOOP;
	
end Behavioral;

