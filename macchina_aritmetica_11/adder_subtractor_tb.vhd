--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:40:16 01/05/2021
-- Design Name:   
-- Module Name:   C:/Users/hp/OneDrive/XilinxISE-Workspace/Progetti/Progetto11/Esercizio11/adder_subtractor_tb.vhd
-- Project Name:  Esercizio11
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: adder_subtractor
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
use work.all;

ENTITY adder_subtractor_tb IS
END adder_subtractor_tb;
 
ARCHITECTURE behavior OF adder_subtractor_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder_subtractor
    PORT(
         op1 : IN  std_logic_vector(7 downto 0);
         op2 : IN  std_logic_vector(7 downto 0);
         subtract : IN  std_logic;
         c_out : OUT  std_logic;
         res : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op1 : std_logic_vector(7 downto 0) := (others => '0');
   signal op2 : std_logic_vector(7 downto 0) := (others => '0');
   signal subtract : std_logic := '0';

 	--Outputs
   signal c_out : std_logic;
   signal res : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.adder_subtractor(Structural) PORT MAP (
          op1 => op1,
          op2 => op2,
          subtract => subtract,
          c_out => c_out,
          res => res
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
      wait for 100 ns;	

      --wait for <clock>_period*10;
		op1<="00000110";
		op2<="00000100";
		subtract <= '0';
		wait for 10 ns;
   	assert res = "00001010";
--		report "addizione0"
--		severity failure;
      -- insert stimulus here 
		op1<="00000110";
		op2<="00000100";
		subtract <= '1';
		wait for 10 ns;
		assert res = "00000010";
--		report "sottrazione1"
--		severity failure;
      wait;
   end process;

END;
