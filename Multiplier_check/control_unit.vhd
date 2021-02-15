----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:03:36 01/05/2021 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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

entity control_unit is
	 Generic(N : integer := 8);
    Port ( q_0 : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           count_overflow : in  STD_LOGIC;
           start : in  STD_LOGIC;
           subtract : out  STD_LOGIC;
           count_in : out  STD_LOGIC;
			  enable_M : out STD_LOGIC;
			  enable_F : out STD_LOGIC;
			  load_A : out STD_LOGIC;
			  load_Q : out STD_LOGIC;
			  reset_regs : out STD_LOGIC;
			  enable_result : out STD_LOGIC;
           shift : out  STD_LOGIC;
			  sel_mux_f : out STD_LOGIC);
end control_unit;

architecture Behavioral of control_unit is

type state is (idle, load_sum, rshift, check_sign_B, final_shift, output);

signal q : state := idle;
begin

control: process(clock)
begin
	if reset = '1' then
		q <= idle;
	elsif (clock'event and clock = '1') then
		case q is
			when idle =>
				if start = '1' then
					q <= load_sum; subtract <= '0'; count_in <= '0'; enable_M <= '1';
					enable_F <= '0'; load_A <= '0'; load_Q <= '1'; reset_regs <= '0';
					enable_result <= '0'; shift <= '0'; sel_mux_f <= '0';
				else
					q <= idle; subtract <= '0'; count_in <= '0'; enable_M <= '0';
					enable_F <= '0'; load_A <= '0'; load_Q <= '0'; reset_regs <= '1';
					enable_result <= '0'; shift <= '0'; sel_mux_f <= '0';
				end if;
			when load_sum =>
				if count_overflow = '1' then
					q <= check_sign_B; subtract <= '0'; count_in <= '0'; enable_M <= '0';
					enable_F <= '0'; load_A <= '0'; load_Q <= '0'; reset_regs <= '0';
					enable_result <= '0'; shift <= '0'; sel_mux_f <= '0';
				else
					q <= rshift; subtract <= '0'; count_in <= '1'; enable_M <= '0';
					enable_F <= '1'; load_A <= '1'; load_Q <= '0'; reset_regs <= '0';
					enable_result <= '0'; shift <= '0'; sel_mux_f <= '0';
				end if;
			when rshift =>
				q <= load_sum; subtract <= '0'; count_in <= '0'; enable_M <= '0';
				enable_F <= '0'; load_A <= '0'; load_Q <= '0'; reset_regs <= '0';
				enable_result <= '0'; shift <= '1'; sel_mux_f <= '0';
			when check_sign_B =>
				q <= final_shift; count_in <= '0'; enable_M <= '0';
				enable_F <= '0'; load_A <= '1'; load_Q <= '0'; reset_regs <= '0';
				enable_result <= '0'; shift <= '0'; sel_mux_f <= '1';
				if q_0 = '1' then
					subtract <= '1';
				else
					subtract <= '0';
				end if;
			when final_shift =>
				q <= output; subtract <= '0'; count_in <= '0'; enable_M <= '0';
				enable_F <= '0'; load_A <= '0'; load_Q <= '0'; reset_regs <= '0';
				enable_result <= '0'; shift <= '1'; sel_mux_f <= '1';
			when output =>
				q <= idle; subtract <= '0'; count_in <= '0'; enable_M <= '0';
				enable_F <= '0'; load_A <= '0'; load_Q <= '0'; reset_regs <= '0';
				enable_result <= '1'; shift <= '0'; sel_mux_f <= '0';
			when others => 
				q <= idle;
		end case;
	end if;
end process;


end Behavioral;

