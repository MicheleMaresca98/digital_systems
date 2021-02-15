--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:56:12 01/05/2021
-- Design Name:   
-- Module Name:   C:/Users/hp/OneDrive/XilinxISE-Workspace/Progetti/Progetto11/Esercizio11/counter_tb.vhd
-- Project Name:  Esercizio11
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: counter
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
 
ENTITY counter_tb IS
END counter_tb;
 
ARCHITECTURE behavior OF counter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         enable : IN  std_logic;
         count : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal enable : std_logic := '0';

 	--Outputs
   signal count : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter PORT MAP (
          clock => clock,
          reset => reset,
          enable => enable,
          count => count
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		reset <= '0';
		enable <= '1';
      wait for clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
