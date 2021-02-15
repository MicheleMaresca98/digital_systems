----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:13:39 11/10/2020 
-- Design Name: 
-- Module Name:    cntrl_unit - Behavioral 
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

entity cntrl_unit is
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
end cntrl_unit;

architecture Cablata of cntrl_unit is
type stato_enum is (in1, in2, op1, op2, idle, end_op);
signal current_state : stato_enum;

begin

cntrl_func : process(clk, rst)
begin
	if (rst = '1') then
		current_state <= idle; sel_a <= '0'; sel_b <= '0'; en_a <= '0';
		en_b <= '0'; received_a <= '0'; received_b <= '0'; end_operation <= '0';
	elsif (clk = '1' and clk'event) then
		case current_state is
			when idle =>
				if (start_a = '1') then
					current_state <= in1; sel_a <= '0'; sel_b <= '0'; en_a <= '0';
					en_b <= '0'; received_a <= '0'; received_b <= '0'; end_operation <= '0';
				else
					current_state <= idle; sel_a <= '0'; sel_b <= '0'; en_a <= '0';
					en_b <= '0'; received_a <= '0'; received_b <= '0'; end_operation <= '0';
				end if;
			when in1 =>
				if (start_a = '1') then
					current_state <= in1; sel_a <= '1'; sel_b <= '0'; en_a <= '0';
					en_b <= '0'; received_a <= '1'; received_b <= '0'; end_operation <= '0';
				elsif (start_b = '1') then
					current_state <= in2; sel_a <= '1'; sel_b <= '0'; en_a <= '0';
					en_b <= '0'; received_a <= '0'; received_b <= '0'; end_operation <= '0';
				else
					current_state <= in1; sel_a <= '1'; sel_b <= '0'; en_a <= '1';
					en_b <= '0'; received_a <= '0'; received_b <= '0'; end_operation <= '0';
				end if;
			when in2 =>
				if (start_b = '1') then
					current_state <= in2; sel_a <= '0'; sel_b <= '1'; en_a <= '0';
					en_b <= '0'; received_a <= '0'; received_b <= '1'; end_operation <= '0';
				else
					current_state <= op1; sel_a <= '0'; sel_b <= '0'; en_a <= '0';
					en_b <= '1'; received_a <= '0'; received_b <= '0'; end_operation <= '0';
				end if;
			when op1 =>
				if (cout = '0') then
					current_state <= op2; sel_a <= '0'; sel_b <= '0'; en_a <= '1';
					en_b <= '0'; received_a <= '0'; received_b <= '0'; end_operation <= '0';
				else
					current_state <= end_op; sel_a <= '0'; sel_b <= '0'; en_a <= '0';
					en_b <= '1'; received_a <= '0'; received_b <= '0'; end_operation <= '0';
				end if;
			when op2 =>
				if (cout = '0') then
					current_state <= op1; sel_a <= '0'; sel_b <= '0'; en_a <= '0';
					en_b <= '0'; received_a <= '0'; received_b <= '0'; end_operation <= '0';
				else
					current_state <= end_op; sel_a <= '0'; sel_b <= '0'; en_a <= '0';
					en_b <= '1'; received_a <= '0'; received_b <= '0'; end_operation <= '0';
				end if;
			when end_op =>
				if (ack = '0') then
					current_state <= end_op; sel_a <= '0'; sel_b <= '0'; en_a <= '0';
					en_b <= '0'; received_a <= '0'; received_b <= '0'; end_operation <= '1';
				else
					current_state <= idle; sel_a <= '0'; sel_b <= '0'; en_a <= '0';
					en_b <= '0'; received_a <= '0'; received_b <= '0'; end_operation <= '0';
				end if;
			when others =>
				current_state <= idle; sel_a <= '0'; sel_b <= '0'; en_a <= '0';
				en_b <= '0'; received_a <= '0'; received_b <= '0'; end_operation <= '0';
			end case;
	end if;
end process;

end Cablata;
