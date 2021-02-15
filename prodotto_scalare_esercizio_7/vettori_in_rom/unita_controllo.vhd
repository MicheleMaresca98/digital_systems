----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:26:00 11/22/2020 
-- Design Name: 
-- Module Name:    unita_controllo - Behavioral 
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
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity unita_controllo is
    Port ( CLK : in  STD_LOGIC;
           START : in  STD_LOGIC;
           EN : out  STD_LOGIC;
           RESET : out  STD_LOGIC;
           A : out  STD_LOGIC_VECTOR(7 downto 0);
           B : out  STD_LOGIC_VECTOR(7 downto 0);
			  abilitazione_risultato : out STD_LOGIC;
			  reset_risultato : out STD_LOGIC);
end unita_controllo;

architecture Behavioral of unita_controllo is

signal PC_next, PC, Next_Prod : unsigned(3 downto 0) :="0000";
			
Component MicroROM is
		Port ( PC : in  unsigned(3 downto 0);
           PC_next : out  unsigned(3 downto 0);
           A : out  STD_LOGIC_VECTOR(7 downto 0);
           B : out  STD_LOGIC_VECTOR(7 downto 0);
           EN : out  STD_LOGIC;
           RESET : out  STD_LOGIC
			);
end component;


begin

		rom: MicroROM
		PORT MAP(PC => PC,
           PC_next => PC_next,
           A => A,
           B => B,
           EN => EN,
           RESET => RESET
				);
				
		reg_PC: PROCESS(CLK)
		variable counter : integer range 0 to 6 := 0;
		BEGIN
		--abilitazione_risultato <= '0';
		if(CLK'event and CLK = '1') then
			if(start = '1') then 
				PC <= "0001";
				counter := 0;
				reset_risultato <= '1';
			else
				reset_risultato <= '0';
				PC<= PC_next;
				counter := counter +1;
				if(counter = 3) then
					Next_Prod <= PC_next;
					abilitazione_risultato <= '1';
				end if;
				if(counter = 4) then
					abilitazione_risultato <= '0';
				end if;
				if(counter = 5) then
					PC <= "0000";
				end if;
				if(counter = 6) then
					PC <= Next_Prod;
					counter := 0;
				end if;
			end if;
		end if;
		end process reg_PC;


end Behavioral;

