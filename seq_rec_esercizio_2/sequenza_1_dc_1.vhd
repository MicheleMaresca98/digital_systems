----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:41:10 10/27/2020 
-- Design Name: 
-- Module Name:    sequenza_1-1 - Behavioral 
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

entity sequenza_1_dc_1 is
    Port ( i : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           y : out  STD_LOGIC);
end sequenza_1_dc_1;

architecture Behavioral of sequenza_1_dc_1 is

type state is (q0, q1, q2, f0, f1);
signal current : state := q0;

begin

seq_rec : process(clk)
begin
	if (clk = '1' and clk'event) then
		if (rst = '1') then
			current <= q0;
			y <= '0';
		else
			case current is
			when q0 =>
				if (i = '1') then
					current <= q1;
				elsif (i = '0') then
					current <= f0;
				end if;
				y <= '0';
			when q1 =>
				current <= q2;
				y <= '0';
			when q2 =>
				current <= q0;
				if (i = '1') then
					y <= '1';
				else
					y <= '0';
				end if;
			when f0 =>
				current <= f1;
				y <= '0';
			when f1 =>
				current <= q0;
				y <= '0';
			when others =>
				current <= q0;
				y <= '0';
			end case;
		end if;
	end if;
end process;


end Behavioral;


architecture Structural of sequenza_1_dc_1 is
-- segnali interni
signal neg_i : std_logic := '0';
signal x0 : std_logic := '0';
signal x1 : std_logic := '0';
signal x2 : std_logic := '0';
signal neg_x0 : std_logic := '0';
signal neg_x1 : std_logic := '0';
signal neg_x2 : std_logic := '0';
signal x0_next : std_logic := '0';
signal x1_next : std_logic := '0';
signal x2_next : std_logic := '0';
signal u0_x1 : std_logic := '0';
signal u1_x1 : std_logic := '0';
signal u_y : std_logic := '0';
-- dispositivi interni
component flip_flop_D is
    Port ( d : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           q : out  STD_LOGIC);
end component;

component logic_and is
	 Generic ( n : positive := 2 );
    Port ( a : in  STD_LOGIC_VECTOR(n-1 downto 0);
           y : out  STD_LOGIC);
end component;

component logic_or is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           y : out  STD_LOGIC);
end component;

component logic_not is
    Port ( a : in  STD_LOGIC;
           y : out  STD_LOGIC);
end component;
begin
	not_x0 : logic_not
	Port map(
		a => x0,
		y => neg_x0
	);
	not_x1 : logic_not
	Port map(
		a => x1,
		y => neg_x1
	);
	not_x2 : logic_not
	Port map(
		a => x2,
		y => neg_x2
	);
	not_i : logic_not
	Port map(
		a => i,
		y => neg_i
	);
	x0_func : logic_and generic map(3)
	Port map (
		a(0) => neg_x0,
		a(1) => neg_x1,
		a(2) => neg_x2,
		y => x0_next
	);
	u0_x1_func : logic_and generic map(3)
	Port map(
		a(0) => neg_i,
		a(1) => neg_x1,
		a(2) => neg_x2,
		y => u0_x1
	);
	u1_x1_func : logic_and generic map(2)
	Port map(
		a(0) => x0,
		a(1) => neg_x1,
		y => u1_x1
	);
	x1_func : logic_or
	Port map(
		a => u0_x1,
		b => u1_x1,
		y => x1_next
	);
	x2_func : logic_and generic map(2)
	Port map(
		a(0) => x0,
		a(1) => x1,
		y => x2_next
	);
	mem0 : flip_flop_D
	Port map(
		d => x0_next,
		clk => clk,
		rst => rst,
		q => x0
	);
	mem1 : flip_flop_D
	Port map(
		d => x1_next,
		clk => clk,
		rst => rst,
		q => x1
	);
	mem2 : flip_flop_D
	Port map(
		d => x2_next,
		clk => clk,
		rst => rst,
		q => x2
	);
	y_func : logic_and generic map(3)
	Port map(
		a(0) => neg_x0,
		a(1) => x1,
		a(2) => i,
		y => u_y
	);
	y_buffer : flip_flop_D
	Port map(
		d => u_y,
		clk => clk,
		rst => rst,
		q => y
	);

end Structural;

