----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:24:17 01/05/2021 
-- Design Name: 
-- Module Name:    ripple_carry_adder - Behavioral 
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

entity ripple_carry_adder is
	Generic(N : integer := 8);
    Port ( op1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           op2 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           c_in : in STD_LOGIC;
           c_out : out  STD_LOGIC;
			  res : out  STD_LOGIC_VECTOR(N-1 downto 0));
end ripple_carry_adder;

architecture Structural of ripple_carry_adder is

component full_adder is
    Port ( op1 : in  STD_LOGIC;
           op2 : in  STD_LOGIC;
           c_in : in  STD_LOGIC;
           c_out : out  STD_LOGIC;
           res : out  STD_LOGIC);
end component;

signal carry_in : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');

begin
	f_a_0: full_adder Port map	(op1 => op1(0), op2 => op2(0), c_in => c_in, c_out => carry_in(1), res => res(0));
	
	 f_a_1toN_2: for i in 1 to N-2 generate
		f_a_i: full_adder Port map	(op1 => op1(i), op2 => op2(i), c_in => carry_in(i), c_out => carry_in(i + 1), res => res(i));
	 end generate;
	
	f_a_N_1: full_adder Port map	(op1 => op1(N - 1), op2 => op2(N - 1), c_in => carry_in(N-1), c_out => c_out, res => res(N - 1));	
end Structural;

