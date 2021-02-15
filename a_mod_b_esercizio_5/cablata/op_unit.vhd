----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:26:44 11/10/2020 
-- Design Name: 
-- Module Name:    op_unit - Behavioral 
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

entity op_unit is
    Port ( x : in  STD_LOGIC_VECTOR(7 downto 0);
           sel_a : in  STD_LOGIC;
           sel_b : in  STD_LOGIC;
           en_a : in  STD_LOGIC;
           en_b : in  STD_LOGIC;
			  rst : in STD_LOGIC;
			  cout : out STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(7 downto 0));
end op_unit;

architecture Structural of op_unit is
-- op1 ed op2 in ingresso all'adder; res in uscita
signal op1 : std_logic_vector(7 downto 0) := (others => '0');
signal op2 : std_logic_vector(7 downto 0) := (others => '0');
signal res : std_logic_vector(7 downto 0) := (others => '0');
-- u_op2 viene negato per ottenre u2
signal u_op2 : std_logic_vector(7 downto 0) := (others => '0');

component not_N_bit is
	 Generic(n : positive := 8);
    Port ( x : in  STD_LOGIC_VECTOR(n-1 downto 0);
           y : out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

component registro_N_bit_multiplexed is
    Generic(n : positive := 8);
    Port ( sel : in  STD_LOGIC;
           en : in  STD_LOGIC;
           a : in  STD_LOGIC_VECTOR(n-1 downto 0);
           b : in  STD_LOGIC_VECTOR(n-1 downto 0);
			  rst : in STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

component adder is
	 Generic(n : positive := 8);
    Port ( a : in  STD_LOGIC_VECTOR(n-1 downto 0);
           b : in  STD_LOGIC_VECTOR(n-1 downto 0);
           y : out  STD_LOGIC_VECTOR(n-1 downto 0);
			  cout : out STD_LOGIC);
end component;

begin
frontend_A : registro_N_bit_multiplexed generic map(n => 8) port map(
	sel => sel_a, en => en_a, a => res, b => x, y => op1, rst => rst
);

frontend_B : registro_N_bit_multiplexed generic map(n => 8) port map(
	sel => sel_b, en => en_b, a => "00000000", b => x, y => u_op2, rst => rst
);

negate : not_N_bit generic map(n => 8) port map(
	x => u_op2, y => op2
);

compare : adder generic map(n => 8) port map(
	a => op1, b => op2, y => res, cout => cout
);

y <= res;

end Structural;

