----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:46:02 10/30/2020 
-- Design Name: 
-- Module Name:    seq_sovr_1_dc_1_0 - Behavioral 
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

entity seq_sovr_1_dc_1_0 is
    Port ( i : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           y : out  STD_LOGIC);
end seq_sovr_1_dc_1_0;

architecture Behavioral of seq_sovr_1_dc_1_0 is
type state is (q0, q1, q2, q3, q4, q5);
signal current : state := q0;
signal next_state : state;
signal next_out : std_logic;

begin
transition : process(i, current, clk)
begin
	case current is
	when q0 =>
		if (i = '1') then
			next_state <= q1;
		else
			next_state <= q0;
		end if;
		next_out <= '0';
	when q1 =>
		if (i = '1') then
			next_state <= q2;
		else
			next_state <= q3;
		end if;
		next_out <= '0';
	when q2 =>
		if (i = '1') then
			next_state <= q4;
		else
			next_state <= q3;
		end if;
		next_out <= '0';
	when q3 =>
		if (i = '1') then
			next_state <= q5;
		else
			next_state <= q0;
		end if;
		next_out <= '0';
	when q4 =>
		if (i = '1') then
			next_state <= q4;
			next_out <= '0';
		else
			next_state <= q3;
			next_out <= '1';
		end if;
	when q5 =>
		if (i = '1') then
			next_out <= '0';
			next_state <= q2;
		else
			next_out <= '1';
			next_state <= q3;
		end if;
		
	when others =>
		next_state <= q0;
		next_out <= '0';
	end case;
	if (clk = '1' and clk'event) then
		y <= next_out;
	end if;
end process;

mem : process(clk, rst)
begin
	if (rst = '1') then
		current <= q0;
	elsif (clk = '1' and clk'event) then
		current <= next_state;
	end if;
end process;

end Behavioral;


architecture Hybrid of seq_sovr_1_dc_1_0 is
-- signals
signal q_next : std_logic_vector(2 downto 0) := (others => '0');
signal q : std_logic_vector(2 downto 0) := (others => '0');
signal y_tmp : std_logic := '0';
-- components
component funzioni_tau_omega is
    Port ( q : in  STD_LOGIC_VECTOR(2 downto 0);
			  i : in  STD_LOGIC;
           q_next : out  STD_LOGIC_VECTOR(2 downto 0);
           y : out  STD_LOGIC );
end component;

component ff_D_async_rst is
    Port ( i : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           q : out  STD_LOGIC);
end component;

begin
	comb_dataflow : funzioni_tau_omega port map(
		q => q, i => i, q_next => q_next, y => y_tmp
	);
	mem_state : for i in 2 downto 0 generate
		mem : ff_D_async_rst port map(
			i => q_next(i), clk => clk, rst => rst, q => q(i)
		);
	end generate;
	buffer_out : ff_D_async_rst port map(
		i => y_tmp, clk => clk, rst => rst, q => y
	);
end Hybrid;

