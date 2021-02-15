----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:59:23 11/18/2020 
-- Design Name: 
-- Module Name:    A_B - Behavioral 
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

entity A_B is
port(
	clk : in std_logic;
	buff_out_in : in std_logic_vector(7 downto 0);
	buff_in_out : in std_logic_vector(7 downto 0);
	to_in : out std_logic_vector(7 downto 0);
	to_out : out std_logic_vector(7 downto 0);
	start : in std_logic;
	syn_out : out std_logic;
	ack_in : in std_logic;
	syn_in : in std_logic;
	ack_out : out std_logic;
	EOOP_in : in std_logic;
	EOOP_out : out std_logic;
	ready : out std_logic);

end A_B;

architecture Behavioral of A_B is

signal a, b : std_logic_vector ( 7 downto 0 ) := ( others => '0' );
type state is ( idle,waitEvent, pollingA, waitAB, pollingB, Ap, Bp, end_op_in, end_op_out);
signal stato, prossimo : state := idle;

begin
	process (clk, start)
		begin
				if ( start = '1' ) then
					to_in <= "00000000";
					to_out <= "00000000";
					ready <= '0';
					prossimo <= waitEvent;
				else
					case stato is 

						when idle =>

							if (clk'event and clk = '1') then
								
									prossimo <= idle;

							end if;
						
						when waitEvent => 
							if (clk'event and clk = '1') then
								
								if syn_in = '1' then
								
									prossimo <= pollingA;
								else
								
									prossimo <= waitEvent;
									
								end if;
							end if;
						
						when pollingA => 
						
							if (clk'event and clk = '1') then
								
								if ack_in = '1' then
									
									a <= buff_out_in;
									syn_out <= '0';
									ack_out <= '0';
									prossimo <= waitAB;
									
								else
									
									syn_out <= '1';
									ack_out <= '1';									
									prossimo <= pollingA;
									
								end if;
							end if;
						
						when waitAB => 
						
							if (clk'event and clk = '1') then
								
								if syn_in = '1' then
								
									prossimo <= pollingB;
								else
									prossimo <= waitAB;
									
								end if;
							end if;
						
						when pollingB => 
						
							if (clk'event and clk = '1') then
								
								if ack_in = '1' then
									
									b <= buff_out_in;
									ready <= '1';
									syn_out <= '0';
									ack_out <= '0';
									prossimo <= Ap;
									
								else
								
									syn_out <= '1';
									ack_out <= '1';
									prossimo <= pollingB;
									
								end if;
							end if;

						when Ap =>

							if (clk'event and clk = '1') then
								
									prossimo <= Bp;	
									to_in <= a;
									
							end if;

						when Bp =>

							if (clk'event and clk = '1') then
									prossimo <= end_op_in;
									to_in <= b;
							end if;
						
						when end_op_in => 
						
							if (clk'event and clk = '1') then
								
								if EOOP_in = '1' then
									
									ready <= '0';									
									prossimo <= end_op_out;
									
								else
									
									syn_out <= '0';
									prossimo <= end_op_in;
								end if;
							end if;

						when end_op_out => 
						
							if (clk'event and clk = '1') then
								
								if ack_in = '1' and syn_in = '1' then
									
									syn_out <= '0';
									ack_out <= '1';
									EOOP_out <= '1';
									prossimo <= idle;
								
								else
									
									ack_out <= '0';
									syn_out <= '1';
									EOOP_out <= '0';
									prossimo <= end_op_out;
									to_out <= buff_in_out;
									
								end if;
							end if;
					end case;
				end if;
	end process;

stato <= prossimo;							

end Behavioral;

