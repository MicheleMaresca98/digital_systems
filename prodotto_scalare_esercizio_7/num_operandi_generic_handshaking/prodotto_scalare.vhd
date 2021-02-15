----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:00:00 11/21/2020 
-- Design Name: 
-- Module Name:    prodotto_scalare - Behavioral 
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

entity prodotto_scalare is
    Generic(n : positive := 8);
    Port ( clk : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
			  start : in  STD_LOGIC;
           M : in  unsigned(n-1 downto 0);
           a : in  unsigned(n-1 downto 0);
           b : in  unsigned(n-1 downto 0);
           ack_end_op : in  STD_LOGIC;
           ack : out  STD_LOGIC;
           end_op : out  STD_LOGIC;
           y : out  unsigned(3*n - 1 downto 0));
end prodotto_scalare;

architecture Structural of prodotto_scalare is

signal current_sum : unsigned(3*n - 1 downto 0) := (others => '0');
signal buff_a : unsigned(n-1 downto 0) := (others => '0');
signal buff_b : unsigned(n-1 downto 0) := (others => '0');
signal internal_rst : std_logic := '0';
signal rst_state : std_logic := '0';
signal step : std_logic := '0';
signal molt_out : unsigned(3*n - 1 downto 0) := (others => '0');
signal op_R : unsigned(3*n - 1 downto 0) := (others => '0');
signal add_out : unsigned(3*n - 1 downto 0) := (others => '0');
signal clk_en : std_logic := '0';

component consumatore is
	 Generic(n : positive := 8);
    Port ( clk : in STD_LOGIC;
	        rst : in STD_LOGIC;
			  syn_in : in  STD_LOGIC;
           ack_in : in  STD_LOGIC;
           a : in  unsigned(n-1 downto 0);
           b : in  unsigned(n-1 downto 0);
           M : in  unsigned(n-1 downto 0);
			  result_in : in  unsigned(3*n - 1 downto 0);
           syn_out : out  STD_LOGIC;
           ack_out : out  STD_LOGIC;
           y : out  unsigned(3*n - 1 downto 0);
			  out_a : out  unsigned(n-1 downto 0);
           out_b : out  unsigned(n-1 downto 0);
			  rst_out : out STD_LOGIC;
			  step : out STD_LOGIC);
end component;

component registro is
	 Generic(n : positive := 8);
    Port ( d : in  unsigned(n-1 downto 0);
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
           q : out  unsigned(n-1 downto 0));
end component;

component sommatore is
	 Generic (n : positive := 8);
    Port ( a : in  unsigned(n-1 downto 0);
           b : in  unsigned(n-1 downto 0);
			  clk : in std_logic;
			  rst : in std_logic;
           y : out  unsigned(n-1 downto 0));
end component;

component moltiplicatore is
	 Generic(n : positive := 8);
    Port ( a : in  unsigned(n-1 downto 0);
           b : in  unsigned(n-1 downto 0);
			  clk : in std_logic;
			  rst : in std_logic;
           y : out  unsigned(3*n - 1 downto 0));
end component;

begin

frontend : consumatore generic map(n) port map(
	clk => clk, rst => rst, syn_in => start, ack_in => ack_end_op, M => M, a => a, 
	result_in => current_sum, syn_out => end_op, ack_out => ack, y => y, b => b,
	out_a => buff_a, out_b => buff_b, rst_out => internal_rst, step => step
);

rst_state <= rst or internal_rst;

clk_en <= clk and step;

molt : moltiplicatore generic map(n) port map(
	a => buff_a, b => buff_b, y => molt_out, clk => clk, rst => rst_state
);

reg_R : registro generic map(3*n) port map(
	d => molt_out, rst => rst_state, en => clk_en, q => op_R
);

reg_S : registro generic map(3*n) port map(
	d => add_out, rst => rst_state, en => clk_en, q => current_sum
);

somma : sommatore generic map(3*n) port map(
	a => current_sum, b => op_R, y => add_out, clk => clk, rst => rst_state
);

end Structural;

