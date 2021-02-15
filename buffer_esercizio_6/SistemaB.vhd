----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:51:02 11/15/2020 
-- Design Name: 
-- Module Name:    SistemaB - Behavioral 
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

entity SistemaB is
    Port ( out_data : in  STD_LOGIC_VECTOR (07 downto 00);
           out_B1 : out  STD_LOGIC_VECTOR (15 downto 00);
           out_B2 : out  STD_LOGIC_VECTOR (15 downto 00);
			  B_rdy : in STD_LOGIC;
			  gotB_rdy : out STD_LOGIC
			  );
end SistemaB;

architecture Behavioral of SistemaB is
	TYPE STATE IS (B_ATTESA_BRDY1, B_ATTESA_BRDY0);
	signal current_state : STATE := B_ATTESA_BRDY1;
begin
B: process
		VARIABLE count: integer range 0 to 4 :=0;
		begin
		case current_state is
			when B_ATTESA_BRDY1 =>
				wait until B_rdy = '1';
				gotB_rdy <= '1';
				current_state <= B_ATTESA_BRDY0;
			when B_ATTESA_BRDY0 =>
				wait until B_rdy = '0';
				gotB_rdy <= '0';
				count := count +1;
				CASE count IS
						When 0 => NULL;
						When 1 => out_B1(07 downto 00)<=out_data;out_B1(15 downto 08)<=(others =>'0');out_B2<=(others =>'0'); current_state <= B_ATTESA_BRDY1;
						When 2 => out_B1(15 downto 08)<=out_data; current_state <= B_ATTESA_BRDY1;
						When 3 => out_B2(07 downto 00)<=out_data;out_B2(15 downto 08)<=(others =>'0'); current_state <= B_ATTESA_BRDY1;
						When 4 => out_B2(15 downto 08)<=out_data; current_state <= B_ATTESA_BRDY1;
				end case;
		end case;
		wait on current_state, B_rdy, out_data;
		end process;

end Behavioral;

