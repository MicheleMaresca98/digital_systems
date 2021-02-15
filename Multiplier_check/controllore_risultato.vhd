----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:39:59 01/11/2021 
-- Design Name: 
-- Module Name:    controllore_risultato - Behavioral 
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

entity controllore_risultato is
	Generic(N : integer := 8; M : integer := 8);
    Port ( P : in  STD_LOGIC_VECTOR(N+M-1 downto 0);
           M1 : in  STD_LOGIC_VECTOR(N+M-1 downto 0);
           M2 : in  STD_LOGIC_VECTOR(N+M-1 downto 0);
           CLK : in  STD_LOGIC;
           enable_check : in  STD_LOGIC;
           FLAG : out  STD_LOGIC;
			  ERROR : out  STD_LOGIC;
			  RST : in STD_LOGIC);
end controllore_risultato;

architecture Behavioral of controllore_risultato is

begin
controllo: process(CLK)
begin
	if (RST = '1') then
		FLAG <= '0';
		ERROR <= '0';
	elsif (CLK'event and CLK = '1') then 
		if (enable_check = '1') then
			if ( ( to_integer(signed(M2)) - to_integer(signed(M1)) ) < 0 ) then
				ERROR <= '1';
				FLAG <= '0';
			else
				ERROR <= '0';
				if ( ( ( to_integer(signed(P)) - to_integer(signed(M1)) ) >= 0 ) and ( (to_integer(signed(P)) - to_integer(signed(M2)) ) <= 0 ) ) then
					FLAG <= '1'; --compreso inteso come M1 <= P <= M2
				else
					FLAG <= '0';
				end if;
			end if;
		end if;
	end if;
end process;
end Behavioral;

