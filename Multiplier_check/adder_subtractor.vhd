----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:20:30 01/05/2021 
-- Design Name: 
-- Module Name:    adder_subtractor - Behavioral 
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

entity adder_subtractor is
	Generic(N : integer := 8);
    Port ( op1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           op2 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           subtract : in  STD_LOGIC;
           c_out : out  STD_LOGIC;
           res : out  STD_LOGIC_VECTOR(N-1 downto 0));
end adder_subtractor;

architecture Behavioral of adder_subtractor is

component adder is
	 Generic(N : integer := 8);
    Port ( op1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           op2 : in  STD_LOGIC_VECTOR(N-1 downto 0);
			  cin : in STD_LOGIC;
           res : out  STD_LOGIC_VECTOR(N-1 downto 0);
           cout : out  STD_LOGIC);
end component;

signal op2_internal : STD_LOGIC_VECTOR(N-1 downto 0);

begin

operand_2: for i in 0 to N-1 generate
	op2_internal(i) <= op2(i) xor subtract;
end generate;

sommatore: adder Generic map(N) 
	Port map(op1 => op1, op2 => op2_internal, cin => subtract, cout => c_out, res => res);


end Behavioral;

architecture Structural of adder_subtractor is

component ripple_carry_adder is
	Generic(N : integer := 8);
    Port ( op1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           op2 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           c_in : in STD_LOGIC;
           c_out : out  STD_LOGIC;
			  res : out  STD_LOGIC_VECTOR(N-1 downto 0));
end component;

signal op2_internal : STD_LOGIC_VECTOR(N-1 downto 0);

begin

operand_2: for i in 0 to N-1 generate
	op2_internal(i) <= op2(i) xor subtract;
end generate;

rca: ripple_carry_adder Generic map(N) 
	Port map(op1 => op1, op2 => op2_internal, c_in => subtract, c_out => c_out, res => res);

end Structural;

