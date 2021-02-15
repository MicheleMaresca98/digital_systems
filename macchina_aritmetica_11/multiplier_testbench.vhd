--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:34:51 01/05/2021
-- Design Name:   
-- Module Name:   /home/marcofelix98/Architettura_dei_Sistemi_Digitali/my_projects/macchina_aritmetica_11/multiplier_testbench.vhd
-- Project Name:  Esercizio11
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Robertson_multiplier
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
 
ENTITY multiplier_testbench IS
END multiplier_testbench;
 
ARCHITECTURE behavior OF multiplier_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Robertson_multiplier
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         START : IN  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic;
         P : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal START : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal P : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Robertson_multiplier PORT MAP (
          A => A,
          B => B,
          START => START,
          CLK => CLK,
          RST => RST,
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
		RST <= '1';
      wait for 100 ns;	
		RST <= '0';
      wait for CLK_period;
		
		A <= "11010101"; -- (-43)
		B <= "10110011"; -- (-77)
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*20;
		
		A <= "00110010"; -- 50
		B <= "10110011"; -- (-77)
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*20;
		
		A <= "11010101"; -- (-43)
		B <= "01000111"; -- 71
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*20;
		
		A <= "00011110"; -- 30
		B <= "00010101"; -- 21
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for CLK_period*20;
		
      wait;
   end process;

END;
