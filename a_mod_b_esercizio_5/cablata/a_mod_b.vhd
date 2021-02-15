----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:02:34 11/11/2020 
-- Design Name: 
-- Module Name:    a_mod_b - Behavioral 
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

entity a_mod_b is
    Port ( clk : in  STD_LOGIC;
           start_a : in  STD_LOGIC;
           start_b : in  STD_LOGIC;
			  ack : in STD_LOGIC;
			  rst : in STD_LOGIC;
           x : in  STD_LOGIC_VECTOR(7 downto 0);
           received_a : out  STD_LOGIC;
           received_b : out  STD_LOGIC;
			  end_operation : out STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(7 downto 0));
end a_mod_b;

architecture Structural of a_mod_b is
signal cout : std_logic := '0'; signal sel_a : std_logic := '0';
signal sel_b : std_logic := '0'; signal en_a : std_logic := '0';
signal en_b : std_logic := '0';

component cntrl_unit is
    Port ( clk : in  STD_LOGIC;
           start_a : in  STD_LOGIC;
			  start_b : in  STD_LOGIC;
           cout : in  STD_LOGIC;
			  ack : in STD_LOGIC;
			  rst : in STD_LOGIC;
           sel_a : out  STD_LOGIC;
           sel_b : out  STD_LOGIC;
           en_a : out  STD_LOGIC;
           en_b : out  STD_LOGIC;
           received_a : out  STD_LOGIC;
			  received_b : out  STD_LOGIC;
			  end_operation : out STD_LOGIC);
end component;

component op_unit is
    Port ( x : in  STD_LOGIC_VECTOR(7 downto 0);
           sel_a : in  STD_LOGIC;
           sel_b : in  STD_LOGIC;
           en_a : in  STD_LOGIC;
           en_b : in  STD_LOGIC;
			  rst : in STD_LOGIC;
			  cout : out STD_LOGIC;
           y : out  STD_LOGIC_VECTOR(7 downto 0));
end component;

begin
cntrl: cntrl_unit port map(
	clk => clk, start_a => start_a, start_b => start_b, cout => cout,
	sel_a => sel_a, sel_b => sel_b, en_a => en_a, en_b => en_b,
	received_a => received_a, received_b => received_b,
	ack => ack, end_operation => end_operation, rst => rst
);

op : op_unit port map(
	x => x, sel_a => sel_a, sel_b => sel_b, en_a => en_a, en_b => en_b,
	cout => cout, y => y, rst => rst
);

end Structural;

