--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:57:11 11/11/2020
-- Design Name:   
-- Module Name:   /home/marcofelix98/Architettura_dei_Sistemi_Digitali/my_projects/a_mod_b_esercizio_5/cntrl_unit_testbench.vhd
-- Project Name:  a_mod_b_esercizio_5
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cntrl_unit
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
 
ENTITY cntrl_unit_testbench IS
END cntrl_unit_testbench;
 
ARCHITECTURE behavior OF cntrl_unit_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cntrl_unit
    PORT(
         clk : IN  std_logic;
         start_a : IN  std_logic;
         start_b : IN  std_logic;
         cout : IN  std_logic;
         ack : IN  std_logic;
			rst : IN std_logic;
         sel_a : OUT  std_logic;
         sel_b : OUT  std_logic;
         en_a : OUT  std_logic;
         en_b : OUT  std_logic;
         received_a : OUT  std_logic;
         received_b : OUT  std_logic;
         end_operation : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal start_a : std_logic := '0';
   signal start_b : std_logic := '0';
   signal cout : std_logic := '0';
   signal ack : std_logic := '0';
	signal rst : std_logic := '0';

 	--Outputs
   signal sel_a : std_logic := '0';
   signal sel_b : std_logic := '0';
   signal en_a : std_logic := '0';
   signal en_b : std_logic := '0';
   signal received_a : std_logic := '0';
   signal received_b : std_logic := '0';
   signal end_operation : std_logic := '0';

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.cntrl_unit(Cablata) PORT MAP (
          clk => clk,
          start_a => start_a,
          start_b => start_b,
          cout => cout,
          ack => ack,
          sel_a => sel_a,
          sel_b => sel_b,
          en_a => en_a,
          en_b => en_b,
          received_a => received_a,
          received_b => received_b,
          end_operation => end_operation,
			 rst => rst
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		rst <= '1';
		wait for clk_period;
		rst <= '0';
		wait for clk_period;
		
		start_a <= '1';
		wait until (received_a = '1');
		start_a <= '0';
		wait until (received_a = '0');
		
		start_b <= '1';
		wait until (received_b = '1');
		start_b <= '0';
		wait until (received_b = '0');
		
		wait for clk_period*6;
		cout <= '1';
		wait until (end_operation = '1');
		ack <= '1';
		wait until (end_operation = '0');
		ack <= '0';

      wait;
   end process;

END;
