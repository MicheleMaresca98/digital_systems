----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:19:39 11/04/2020 
-- Design Name: 
-- Module Name:    REG_SS_4_BIT - Behavioral 
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

entity REG_SS_4_BIT is
	generic( N: integer := 4);
    Port ( CLK : in  STD_LOGIC;
           SHIFT : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
			  LOAD: in STD_LOGIC;
			  A: in STD_LOGIC_VECTOR(0 TO N-1);
           RESET : in  STD_LOGIC;
           X : in  STD_LOGIC;
           Y : out  STD_LOGIC);
end REG_SS_4_BIT;

architecture Behavioral of REG_SS_4_BIT is

signal T: std_logic_vector(0 to N-1);
signal Yinternal: std_logic;

begin

	reg:PROCESS (CLK)
	BEGIN
			if(CLK'event and CLK = '1') then
				if(RESET = '1') then
					T <= (others => '0');
					Yinternal <= T(N-1);
				elsif(LOAD = '1') then
					T <= A;
					Yinternal <= T(N-1);
				else
					CASE SHIFT IS
						WHEN "00" =>
							T(0) <= '0';
							T(1 to N-1) <= T(0 to N-2);
							Yinternal <= T(N-1);
						WHEN "01" =>
							T(0 to N-2) <= T(1 to N-1);
							T(N-1) <= '0';
						WHEN "10" =>
							T(0) <= T(N-1);
							T(1 to N-1) <= T(0 to N-2);
							Yinternal <= T(N-1);
						WHEN "11" =>
							T(0) <= X;
							T(1 to N-1) <= T(0 to N-2);
							Yinternal <= T(N-1);
						WHEN OTHERS =>
							T <=(others => '0');
					END CASE;
				end if;
			end if;
	END PROCESS;

	Y <= Yinternal;

end Behavioral;

