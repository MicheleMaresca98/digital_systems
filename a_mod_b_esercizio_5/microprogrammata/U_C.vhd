----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:42:31 11/18/2020 
-- Design Name: 
-- Module Name:    U_C - Behavioral 
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

entity U_C is
	PORT (
		ready : IN std_logic;
		clk : IN std_logic;
		start : IN std_logic;
		cout : IN std_logic;
		selA : OUT std_logic;
		enA : OUT std_logic;
		selB : OUT std_logic;
		enB : OUT std_logic;
		EOOP : OUT std_logic
	);
end U_C;

architecture hybrid of U_C is
	component ROM is 
		Port ( 
			PC : IN unsigned (2 downto 0);
			PC_next : OUT unsigned (2 downto 0);
			jcout : OUT std_logic;
			selA : OUT std_logic;
			enA : OUT std_logic;
			selB : OUT std_logic;
			enB : OUT std_logic;
			EOOP : OUT std_logic
		);
	end component;

	signal jcout : std_logic;
	signal PC, PC_next : unsigned (2 downto 0):= "000";
begin

MicroRom : ROM
		port map (
					PC => PC,
					PC_next => PC_next,
					jcout => jcout,
					selA => selA,
					enA => enA, 
					selB => selB,
					enB => enB, 
					EOOP => EOOP
		);
		
	control : process (clk)
					begin


						 if (clk = '1' and clk'event) then
								
								if (ready = '0') then
									PC <= (others => '0');
							   elsif (jcout = '1' and cout = '0') then
									PC <= "101";
							   else
									PC <= PC_next;
							end if;
						end if;

					end process;
								

end hybrid;

--							if start = '1' then PC <= "001";
--							else
--								case PC is
--								
--									when "000" =>
--									if ( clk'event and clk = '1' ) then
--										PC <= "000";
--									end if;
--									when "001" =>
--									if ( clk'event and clk = '1' ) then
--										if readyA = '1' then
--											PC <= PC_next;
--											gotA <= '1';
--										else
--											gotA <= '0';
--											PC <= PC;										
--										end if;
--									end if;
--									when "010" =>
--									if ( clk'event and clk = '1' ) then
----										if readyB = '1' then
----											gotB <= '1';
--											PC <= PC_next;
----										else
----											gotB <= '0';
----											PC <= PC;											
----										end if;
--										end if;
--									when "011" =>
--										if jcout = '1' then
--											if cout = '0' then
--													PC <= PC_next;
--											elsif ( clk'event and clk = '1' ) then
--												PC <= PC;
--										end if;
--										end if;
--									when "100" =>
--										if ( clk'event and clk = '1' ) then
--												
--												PC <= PC_next;
--										
--										end if;
--								
--								when others =>
--									end case;
--								end if;