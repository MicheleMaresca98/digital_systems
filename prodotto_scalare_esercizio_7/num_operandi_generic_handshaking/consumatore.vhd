----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:59:00 11/20/2020 
-- Design Name: 
-- Module Name:    consumatore - Behavioral 
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

entity consumatore is
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
end consumatore;

architecture Structural of consumatore is

signal overflow : std_logic := '0';
signal set : std_logic := '0';
signal par_cnt : unsigned(n-1 downto 0) := (others => '0');
type state is (idle, data_in, end_op);
signal current : state := idle;

component contatore is
	 Generic(n : positive := 8);
    Port ( clk : in  STD_LOGIC;
           set : in  STD_LOGIC;
           par : in  unsigned(n-1 downto 0);
           rst : in  STD_LOGIC;
           overflow : out  STD_LOGIC);
end component;

begin

count : contatore generic map(n) port map(
	clk => clk, set => set, par => par_cnt, rst => rst, overflow => overflow
);

out_a <= a;
out_b <= b;
y <= result_in;

cons : process(clk, rst)
constant max_cont : unsigned(n-1 downto 0) := (others => '1');
begin
	if (rst = '1') then
		current <= idle; syn_out <= '0'; ack_out <= '0'; rst_out <= '0';
	elsif (clk = '1' and clk'event) then
		case current is
			when idle =>
				if (syn_in = '1') then
					current <= data_in; ack_out <= '1'; rst_out <= '1'; step <= '0';
					set <= '1'; par_cnt <= max_cont - M + 1;
				else
					current <= idle; rst_out <= '0'; step <= '0';
				end if;
			when data_in =>
				if (overflow = '1') then
					current <= end_op; set <= '0'; step <= '0'; rst_out <= '0';
				else
					current <= data_in; set <= '0';
					step <= '1'; rst_out <= '0'; ack_out <= '0';
				end if;
			when end_op =>
				if (ack_in = '0') then
					current <= end_op; syn_out <= '1';
					step <= '0';
				else
					current <= idle; rst_out <= '0'; step <= '0'; syn_out <= '0';
				end if;
			when others =>
				current <= idle; rst_out <= '1';
			end case;
	end if;
end process;

end Structural;

