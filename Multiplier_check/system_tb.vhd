--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:10:44 01/11/2021
-- Design Name:   
-- Module Name:   C:/Users/hp/OneDrive/Desktop/macchina_aritmetica_11/system_tb.vhd
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
 
ENTITY system_tb IS
END system_tb;
 
ARCHITECTURE behavior OF system_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT system
    PORT(
         M1 : IN  std_logic_vector(15 downto 0);
         M2 : IN  std_logic_vector(15 downto 0);
         FLAG : OUT  std_logic;
			ERROR : OUT  std_logic;
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
   signal RST : std_logic := '1';
   signal CLK : std_logic := '0';
   signal START : std_logic := '0';
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal FLAG : std_logic;
	signal ERROR : std_logic;
   signal P : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: system PORT MAP (
          M1 => M1,
          M2 => M2,
          FLAG => FLAG,
			 ERROR => ERROR,
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
		
		A <= "00011110"; -- 30
		B <= "00010101"; -- 21
		M1 <= "0000000000000101"; -- 5
		M2 <= "0000001010111100"; -- 700
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '1'
		report "Errore00"
		severity failure;
		assert ERROR = '0'
		report "Errore01"
		severity failure;
		
		M1 <= "0000000000000101"; -- 5
		M2 <= "0000000100101100"; -- 300
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore10"
		severity failure;
		assert ERROR = '0'
		report "Errore11"
		severity failure;
		
		M1 <= "1111111111111011"; -- -5
		M2 <= "0000001010111100"; -- 700
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '1'
		report "Errore20"
		severity failure;
		assert ERROR = '0'
		report "Errore21"
		severity failure;
		
		--M1 negativo
		
		M1 <= "1111111111111011"; -- -5
		M2 <= "0000000100101100"; -- 300
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore30"
		severity failure;
		assert ERROR = '0'
		report "Errore31"
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
		report "Errore40"
		severity failure;
		assert ERROR = '0'
		report "Errore41"
		severity failure;
		
		--P negativo e FLAG basso

		M1 <= "1111111111111011"; -- -5
		M2 <= "0000000100101100"; -- 300
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore50"
		severity failure;
		assert ERROR = '0'
		report "Errore51"
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
		report "Errore60"
		severity failure;
		assert ERROR = '0'
		report "Errore61"
		severity failure;
		
		--Flag di errore
		M1 <= "0000001010111100"; -- 700
		M2 <= "0000000000000101"; -- 5
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore70"
		severity failure;
		assert ERROR = '1'
		report "Errore71"
		severity failure;
		
		
		 
		M1 <= "0000001001110110"; -- 630
		M2 <= "0000001001110110"; -- 630
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '1' -- perchè il numero è uguale all'estremo
		report "Errore80"
		severity failure;
		assert ERROR = '0'
		report "Errore81"
		severity failure;
		
		M1 <= "0000001001110111"; -- 631
		M2 <= "0000001001110111"; -- 631
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore90"
		severity failure;
		assert ERROR = '0'
		report "Errore91"
		severity failure;
		
		M1 <= "0000001001110110"; -- 630
		M2 <= "0000001001110111"; -- 631
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '1'
		report "Errore100"
		severity failure;
		assert ERROR = '0'
		report "Errore101"
		severity failure;
		
		M1 <= "0000001001110111"; -- 631
		M2 <= "0000001001110111"; -- 631
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '0'
		report "Errore110"
		severity failure;
		assert ERROR = '0'
		report "Errore111"
		severity failure;
		
		M1 <= "0000001001110100"; -- 628
		M2 <= "0000001001110110"; -- 630
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*30;
		assert FLAG = '1'
		report "Errore120"
		severity failure;
		assert ERROR = '0'
		report "Errore121"
		severity failure;
		
      wait;
   end process;

END;
