--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:26:32 01/03/2021
-- Design Name:   
-- Module Name:   C:/Users/inggi/Desktop/Primo Anno Magistrale/Primo Semestre/Asdi/elaborato ASDi/Esercizio10b/node_tb.vhd
-- Project Name:  Esercizio10b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: node
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
 
ENTITY node_tb IS
END node_tb;
 
ARCHITECTURE behavior OF node_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT node
    PORT(
         i0 : IN  std_logic_vector(2 downto 0);
         i1 : IN  std_logic_vector(2 downto 0);
         dest_i0 : IN  std_logic;
         dest_i1 : IN  std_logic;
         u0 : OUT  std_logic_vector(2 downto 0);
         u1 : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i0 : std_logic_vector(2 downto 0) := (others => '0');
   signal i1 : std_logic_vector(2 downto 0) := (others => '0');
   signal dest_i0 : std_logic := '0';
   signal dest_i1 : std_logic := '0';

 	--Outputs
   signal u0 : std_logic_vector(2 downto 0);
   signal u1 : std_logic_vector(2 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: node PORT MAP (
          i0 => i0,
          i1 => i1,
          dest_i0 => dest_i0,
          dest_i1 => dest_i1,
          u0 => u0,
          u1 => u1
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		i0 <= "100";
		i1 <= "111";
		dest_i0 <= '1';
		dest_i1 <= '1';	

      -- insert stimulus here 

      wait;
   end process;

END;
