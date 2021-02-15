----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:56:50 11/15/2020 
-- Design Name: 
-- Module Name:    fsmB - Behavioral 
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

entity fsmB is
    Port ( word_buffer : in  STD_LOGIC_VECTOR(07 downto 00);
           out_data : out  STD_LOGIC_VECTOR(07 downto 00);
           buffer_full : in  STD_LOGIC;
           buffer_picked : out  STD_LOGIC;
           B_rdy : out  STD_LOGIC;
           gotB_rdy : in  STD_LOGIC);
end fsmB;

architecture Behavioral of fsmB is
	TYPE STATE IS (FSMB_ATTESA_BUFFERFULL1, FSMB_ATTESA_BUFFERFULL0, FSMB_ATTESA_GOTBRDY);
	signal current_state : STATE := FSMB_ATTESA_BUFFERFULL1;

begin
	U_C: process
		begin
		case current_state is
			when FSMB_ATTESA_BUFFERFULL1 =>
				wait until buffer_full = '1';
				buffer_picked <= '1';B_rdy <= '0';
				out_data <= word_buffer;
				current_state <= FSMB_ATTESA_BUFFERFULL0;
			when FSMB_ATTESA_BUFFERFULL0 =>
				wait until buffer_full = '0';
				buffer_picked <= '0';
				B_rdy <= '1';
				current_state <= FSMB_ATTESA_GOTBRDY;
			when FSMB_ATTESA_GOTBRDY =>
				wait until gotB_rdy ='1';	
				B_rdy <= '0';buffer_picked <= '0';
				current_state <= FSMB_ATTESA_BUFFERFULL1;
		end case;
		wait on current_state,  buffer_full,  gotB_rdy, word_buffer;
		end process;

end Behavioral;

