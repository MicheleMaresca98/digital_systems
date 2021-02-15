----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:55:50 11/15/2020 
-- Design Name: 
-- Module Name:    fsmA - Behavioral 
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

entity fsmA is
    Port ( in_data : in  STD_LOGIC_VECTOR(03 downto 00);
           word_buffer : out  STD_LOGIC_VECTOR(07 downto 00);
           A_rdy : out  STD_LOGIC;
           gotA_rdy : in  STD_LOGIC;
           in_rcvd : out  STD_LOGIC;
           in_rdy : in  STD_LOGIC;
           buffer_picked : in  STD_LOGIC;
           buffer_full : out  STD_LOGIC);
end fsmA;

architecture Behavioral of fsmA is
	TYPE STATE IS (FSMA_INVIO_ARDY, FSMA_ATTESA_GOTARDY, 
		FSMA_ATTESA_INRDY1, FSMA_ATTESA_INRDY0, FSMA_ATTESA_BUFFERPICKED);
	signal current_state : STATE := FSMA_INVIO_ARDY;

begin
	U_C: process
		VARIABLE count: integer range 0 to 3 :=0;
		begin
		case current_state is
			when FSMA_INVIO_ARDY =>
				A_rdy <= '1';in_rcvd <= '0';buffer_full <= '0';
				current_state <= FSMA_ATTESA_GOTARDY;
			when FSMA_ATTESA_GOTARDY =>
				wait until gotA_rdy = '1';
				A_rdy <= '0'; in_rcvd <= '0';buffer_full <= '0';
				current_state <= FSMA_ATTESA_INRDY1;
			when FSMA_ATTESA_INRDY1 =>
					A_rdy <= '0';buffer_full <= '0';
					if count < 2  then
					if in_rdy = '0' then
					wait until in_rdy ='1';	
					end if;
					end if;
					count := count +1;
					CASE count IS
						When 0 => NULL; in_rcvd <= '0';
						When 1 => word_buffer(03 downto 00) <= in_data;in_rcvd <= '1'; current_state <= FSMA_ATTESA_INRDY0;
						When 2 => word_buffer(07 downto 04) <= in_data;in_rcvd <= '1'; current_state <= FSMA_ATTESA_INRDY0;
						When 3 => count:=0; buffer_full <= '1'; current_state <= FSMA_ATTESA_BUFFERPICKED;
					end case;
			when FSMA_ATTESA_INRDY0 =>
				--if in_rdy = '1' then
				wait until in_rdy = '0';
				--end if;
				in_rcvd <= '0';A_rdy <= '0'; --buffer_full <= '0';
				current_state <=FSMA_ATTESA_INRDY1;
			when FSMA_ATTESA_BUFFERPICKED => 
				wait until buffer_picked <= '1';
				buffer_full <= '0';A_rdy <= '0'; in_rcvd <= '0';
				current_state <=FSMA_ATTESA_INRDY1;
		end case;
		wait on current_state,gotA_rdy, in_rdy, buffer_picked, in_data;
		end process;

end Behavioral;

