--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:01:57 11/15/2020
-- Design Name:   
-- Module Name:   C:/Users/hp/OneDrive/XilinxISE-Workspace/Progetti/Progetto6/Esercizio6/system_tb.vhd
-- Project Name:  Esercizio6
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
         in_A1 : IN  std_logic_vector(15 downto 0);
         in_A2 : IN  std_logic_vector(15 downto 0);
         out_B1 : OUT  std_logic_vector(15 downto 0);
         out_B2 : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_A1 : std_logic_vector(15 downto 0) := (others => '0');
   signal in_A2 : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal out_B1 : std_logic_vector(15 downto 0) := (others => '0');
   signal out_B2 : std_logic_vector(15 downto 0) := (others => '0');
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: system PORT MAP (
          in_A1 => in_A1,
          in_A2 => in_A2,
          out_B1 => out_B1,
          out_B2 => out_B2
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
		-- insert stimulus here 
		in_A1<="0000001011001111";
		in_A2<="1111110111000011";
      wait for 400 ns;
		assert out_B1 = "0000001011001111"
		report "errore0"
		severity failure;
		wait for 400 ns;
		assert out_B2 = "1111110111000011"
		report "errore1"
		severity failure;

      wait;
   end process;

END;
