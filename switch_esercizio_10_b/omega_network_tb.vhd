--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:52:33 01/03/2021
-- Design Name:   
-- Module Name:   C:/Users/hp/OneDrive/XilinxISE-Workspace/Progetti/Progetto10/Esercizio10b/omega_network_tb.vhd
-- Project Name:  Esercizio10b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: omega_network
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
 
ENTITY omega_network_tb IS
END omega_network_tb;
 
ARCHITECTURE behavior OF omega_network_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT omega_network
    PORT(
         i : IN  std_logic_vector(23 downto 0);
         dest_i : IN  std_logic_vector(23 downto 0);
         u : OUT  std_logic_vector(23 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i : std_logic_vector(23 downto 0) := (others => '0');
   signal dest_i : std_logic_vector(23 downto 0) := (others => '0');

 	--Outputs
   signal u : std_logic_vector(23 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: omega_network PORT MAP (
          i => i,
          dest_i => dest_i,
          u => u
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 

      wait;
   end process;

END;
