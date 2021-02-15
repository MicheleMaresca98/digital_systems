--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:17:11 01/11/2021
-- Design Name:   
-- Module Name:   C:/Users/hp/OneDrive/Desktop/EsercizioEsameASDi_v3/systemV3_tb.vhd
-- Project Name:  Esercizio11
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: system
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY systemV3_tb IS
END systemV3_tb;
 
ARCHITECTURE behavior OF systemV3_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT system
    PORT(
         M1 : IN  std_logic_vector(15 downto 0);
         M2 : IN  std_logic_vector(15 downto 0);
         N1 : IN  integer;
         FLAG : OUT  std_logic;
         ERROR : OUT  std_logic;
			ERROR_N1 : OUT std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         START : IN  std_logic;
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         P : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal M1 : std_logic_vector(15 downto 0) := (others => '0');
   signal M2 : std_logic_vector(15 downto 0) := (others => '0');
   signal N1 : integer := 8;
   signal RST : std_logic := '1';
   signal CLK : std_logic := '0';
   signal START : std_logic := '0';
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal FLAG : std_logic;
   signal ERROR : std_logic;
	signal ERROR_N1 : std_logic;
   signal P : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: system PORT MAP (
          M1 => M1,
          M2 => M2,
          N1 => N1,
          FLAG => FLAG,
          ERROR => ERROR,
			 ERROR_N1 => ERROR_N1,
          RST => RST,
          CLK => CLK,
          START => START,
          A => A,
          B => B,
          P => P
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		RST <= '0';
		
		N1 <= 10;
		
		A <= "00011110"; -- 30
		B <= "00010101"; -- 21
		M1 <= "0000000000000101"; -- 5
		M2 <= "0000001010111100"; -- 700
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period;
		assert ERROR_N1 = '1'
		report "Errore"
		severity failure;
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore0"
		severity failure;
		assert ERROR = '0'
		report "Errore1"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore2"
		severity failure;
		
		
		N1 <= 8;
		A <= "00011110"; -- 30
		B <= "00010101"; -- 21
		M1 <= "0000000000000101"; -- 5
		M2 <= "0000001010111100"; -- 700
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '1'
		report "Errore3"
		severity failure;
		assert ERROR = '0'
		report "Errore4"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore5"
		severity failure;
		assert P = "0000001001110110" --630
		report "Errore6"
		severity failure;
		
		M1 <= "0000000000000101"; -- 5
		M2 <= "0000000100101100"; -- 300
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore7"
		severity failure;
		assert ERROR = '0'
		report "Errore8"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore9"
		severity failure;
		assert P = "0000001001110110" --630
		report "Errore10"
		severity failure;
		
		M1 <= "1111111111111011"; -- -5
		M2 <= "0000001010111100"; -- 700
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '1'
		report "Errore10"
		severity failure;
		assert ERROR = '0'
		report "Errore12"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore13"
		severity failure;
		assert P = "0000001001110110" --630
		report "Errore14"
		severity failure;
		
		--M1 negativo
		
		M1 <= "1111111111111011"; -- -5
		M2 <= "0000000100101100"; -- 300
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore15"
		severity failure;
		assert ERROR = '0'
		report "Errore16"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore17"
		severity failure;
		assert P = "0000001001110110" --630
		report "Errore18"
		severity failure;
		
		--P negativo e FLAG alto
		A <= "10100110"; -- -90
		B <= "00000010"; -- 2
		
		M1 <= "1111111100111000"; -- -200
		M2 <= "0000001010111100"; -- 700
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '1'
		report "Errore19"
		severity failure;
		assert ERROR = '0'
		report "Errore20"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore21"
		severity failure;
		assert P = "1111111101001100" -- -180
		report "Errore22"
		severity failure;
		
		--P negativo e FLAG basso

		M1 <= "1111111111111011"; -- -5
		M2 <= "0000000100101100"; -- 300
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore23"
		severity failure;
		assert ERROR = '0'
		report "Errore24"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore25"
		severity failure;
		assert P = "1111111101001100" -- -180
		report "Errore26"
		severity failure;
		
		A <= "00011110"; -- 30
		B <= "00010101"; -- 21
		M1 <= "0000000000000101"; -- 5
		M2 <= "0000001010111100"; -- 700
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '1'
		report "Errore27"
		severity failure;
		assert ERROR = '0'
		report "Errore28"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore29"
		severity failure;
		assert P = "0000001001110110" --630
		report "Errore30"
		severity failure;
		
		--Flag di errore
		M1 <= "0000001010111100"; -- 700
		M2 <= "0000000000000101"; -- 5
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore31"
		severity failure;
		assert ERROR = '1'
		report "Errore32"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore33"
		severity failure;
		
		
		 
		M1 <= "0000001001110110"; -- 630
		M2 <= "0000001001110110"; -- 630
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '1' -- perchè il numero è uguale all'estremo
		report "Errore34"
		severity failure;
		assert ERROR = '0'
		report "Errore35"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore36"
		severity failure;
		assert P = "0000001001110110" --630
		report "Errore37"
		severity failure;
		
		M1 <= "0000001001110111"; -- 631
		M2 <= "0000001001110111"; -- 631
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore38"
		severity failure;
		assert ERROR = '0'
		report "Errore39"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore40"
		severity failure;
		assert P = "0000001001110110" --630
		report "Errore41"
		severity failure;
		
		M1 <= "0000001001110110"; -- 630
		M2 <= "0000001001110111"; -- 631
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '1'
		report "Errore42"
		severity failure;
		assert ERROR = '0'
		report "Errore43"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore44"
		severity failure;
		assert P = "0000001001110110" --630
		report "Errore45"
		severity failure;
		
		M1 <= "0000001001110111"; -- 631
		M2 <= "0000001001110111"; -- 631
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore46"
		severity failure;
		assert ERROR = '0'
		report "Errore47"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore48"
		severity failure;
		assert P = "0000001001110110" --630
		report "Errore49"
		severity failure;
		
		M1 <= "0000001001110100"; -- 628
		M2 <= "0000001001110110"; -- 630
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '1'
		report "Errore50"
		severity failure;
		assert ERROR = '0'
		report "Errore51"
		severity failure;
		assert P = "0000001001110110" --630
		report "Errore52"
		severity failure;
		
		-- prova N1 minore di N
		
		N1 <= 4;-- 4 bit
		A <= "00000111";-- 7 anche su 4 bit
		B <= "00000010";-- 2
		M1 <= "0000000000001111"; -- 15
		M2 <= "0000000000101100"; -- 44
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore53"
		severity failure;
		assert ERROR = '0'
		report "Errore54"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore"
		severity failure;
		assert P = "0000000000001110" --14
		report "Errore55"
		severity failure;
		
		N1 <= 4;-- 4 bit
		A <= "00001011";-- -5 su 4 bit
		B <= "00000001";-- 1
		M1 <= "0000000011111010"; -- -6
		M2 <= "0000000000101100"; -- 44
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '1'
		report "Errore56"
		severity failure;
		assert ERROR = '0'
		report "Errore57"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore"
		severity failure;
		assert P = "1111111111111011" -- -5
		report "Errore58"
		severity failure;
		
		-- di nuovo controllo su N1
		N1 <= 10;
		
		A <= "00011110"; -- 30
		B <= "00010101"; -- 21
		M1 <= "0000000000000101"; -- 5
		M2 <= "0000001010111100"; -- 700
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period;
		assert ERROR_N1 = '1'
		report "Errore59"
		severity failure;
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore60"
		severity failure;
		assert ERROR = '0'
		report "Errore61"
		severity failure;
		
		
		N1 <= 8;
		A <= "00011110"; -- 30
		B <= "00010101"; -- 21
		M1 <= "0000000000000101"; -- 5
		M2 <= "0000001010111100"; -- 700
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '1'
		report "Errore62"
		severity failure;
		assert ERROR = '0'
		report "Errore63"
		severity failure;
		assert ERROR_N1 = '0'
		report "Errore64"
		severity failure;
		assert P = "0000001001110110" --630
		report "Errore65"
		severity failure;
		assert P = "0000001001110111" --631
		report "Errore66"
		severity failure;--per interrompere simulazione
      wait;
   end process;

END;
