--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:00:56 10/27/2020
-- Design Name:   
-- Module Name:   /home/marcofelix98/Architettura_dei_Sistemi_Digitali/my_projects/seq_rec_esercizio_2/sequenza_1_dc_1_behavioral_testbench.vhd
-- Project Name:  seq_rec_esercizio_2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sequenza_1_dc_1
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
use work.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY sequenza_1_dc_1_behavioral_testbench IS
END sequenza_1_dc_1_behavioral_testbench;
 
ARCHITECTURE behavior OF sequenza_1_dc_1_behavioral_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sequenza_1_dc_1
    PORT(
         i : IN  std_logic;
         clk : IN  std_logic;
			rst : IN std_logic;
         y : OUT  std_logic
        );
    END COMPONENT;
    
   --Inputs
   signal i : std_logic := '0';
   signal clk : std_logic := '0';
	signal rst : std_logic := '0';

 	--Outputs
   signal y : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.sequenza_1_dc_1(Behavioral) PORT MAP (
          i => i,
          clk => clk,
			 rst => rst,
          y => y
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
   -- Stimulus process
   stim_proc: process
   begin		
      wait for clk_period * 10;	
		
		rst <= '1';
		wait for clk_period;
		rst <= '0';
		i <= '1';
      wait for clk_period;
		i <= '0';
		wait for clk_period;
		i <= '1';
		wait for clk_period;
		assert y = '1';
		
		
		i <= '1';
      wait for clk_period;
		i <= '1';
		wait for clk_period;
		i <= '1';
		wait for clk_period;
		assert y = '1';



		i <= '0';
      wait for clk_period;
		i <= '1';
		wait for clk_period;
		i <= '1';
		wait for clk_period;
		assert y = '0';

      wait;
   end process;

END;
