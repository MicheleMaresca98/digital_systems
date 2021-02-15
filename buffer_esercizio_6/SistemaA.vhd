----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:50:17 11/15/2020 
-- Design Name: 
-- Module Name:    SistemaA - Behavioral 
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

entity SistemaA is
    Port ( in_A1 : in  STD_LOGIC_VECTOR (15 downto 00);
           in_A2 : in  STD_LOGIC_VECTOR (15 downto 00);
           in_data : out  STD_LOGIC_VECTOR (03 downto 00);
			  A_rdy : in STD_LOGIC;
			  gotA_rdy : out STD_LOGIC;
			  in_rdy : out STD_LOGIC;
			  in_rcvd : in STD_LOGIC
			  );
end SistemaA;

architecture Behavioral of SistemaA is
	TYPE STATE IS (A_ATTESA_ARDY1, A_ATTESA_ARDY0, A_INVIO_DATO, A_ATTESA_INRCVD);
	--TYPE INDICE_PAROLA IS (PRIMA, SECONDA);
	signal current_state : STATE := A_ATTESA_ARDY1;
	--signal parola : INDICE_PAROLA := PRIMA;
begin
	A: process
		VARIABLE count: integer range 0 to 9 :=0;
		begin
		case current_state is
			when A_ATTESA_ARDY1 =>
				wait until A_rdy = '1';
				gotA_rdy <= '1';in_rdy <= '0';
				current_state <= A_ATTESA_ARDY0;
			when A_ATTESA_ARDY0 =>
				wait until A_rdy = '0';
				gotA_rdy <= '0';in_rdy <= '0';
				current_state <= A_INVIO_DATO;
			when A_INVIO_DATO =>
					gotA_rdy <= '0';
					count := count +1;
					CASE count IS
						When 0 => NULL; in_rdy <= '0';
						When 1 => wait for 50ns; in_data <= in_A1(03 downto 00);in_rdy <= '1'; current_state <= A_ATTESA_INRCVD;
						When 2 => wait for 50ns; in_data <= in_A1(07 downto 04);in_rdy <= '1'; current_state <= A_ATTESA_INRCVD;
						When 3 => wait for 50ns; in_data <= in_A1(11 downto 08);in_rdy <= '1'; current_state <= A_ATTESA_INRCVD;
						When 4 => wait for 50ns; in_data <= in_A1(15 downto 12);in_rdy <= '1'; current_state <= A_ATTESA_INRCVD;
						When 5 => wait for 50ns; in_data <= in_A2(03 downto 00);in_rdy <= '1'; current_state <= A_ATTESA_INRCVD;
						When 6 => wait for 50ns; in_data <= in_A2(07 downto 04);in_rdy <= '1'; current_state <= A_ATTESA_INRCVD;
						When 7 => wait for 50ns; in_data <= in_A2(11 downto 08);in_rdy <= '1'; current_state <= A_ATTESA_INRCVD;
						When 8 => wait for 50ns; in_data <= in_A2(15 downto 12);in_rdy <= '1'; current_state <= A_ATTESA_INRCVD;
						When 9 => count := 0; in_rdy <= '0'; current_state <= A_ATTESA_ARDY1;
					end case;
			when A_ATTESA_INRCVD => 
				wait until in_rcvd <= '1';
				in_rdy <= '0';
				gotA_rdy <= '0';
				current_state <= A_INVIO_DATO;
		end case;
		wait on current_state, A_rdy, in_rcvd;
		end process;
	
		


end Behavioral;

