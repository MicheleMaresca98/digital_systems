--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:17:18 11/21/2020
-- Design Name:   
-- Module Name:   C:/Users/hp/OneDrive/XilinxISE-Workspace/Progetti/Progetto7/Esercizio7/moltiplicatore_tb.vhd
-- Project Name:  Esercizio7
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Moltiplicatore
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
 
ENTITY moltiplicatore_tb IS
END moltiplicatore_tb;
 
ARCHITECTURE behavior OF moltiplicatore_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Moltiplicatore
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         AperB : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal AperB : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Moltiplicatore PORT MAP (
          A => A,
          B => B,
          AperB => AperB
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      --wait for 100 ns;	

      --wait for <clock>_period*10;

      -- insert stimulus here 
		A<="00000100";
		B<="00000110";
		wait for 100 ns;
		assert AperB="00011000"
		severity failure;
      wait;
   end process;

END;
