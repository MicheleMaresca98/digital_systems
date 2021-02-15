--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:53:01 11/11/2020
-- Design Name:   
-- Module Name:   /home/marcofelix98/Architettura_dei_Sistemi_Digitali/my_projects/a_mod_b_esercizio_5/negate_testbench.vhd
-- Project Name:  a_mod_b_esercizio_5
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: not_N_bit
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
 
ENTITY negate_testbench IS
END negate_testbench;
 
ARCHITECTURE behavior OF negate_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT not_N_bit
    PORT(
         x : IN  std_logic_vector(7 downto 0);
         y : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal y : std_logic_vector(7 downto 0) := (others => '0');
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: not_N_bit PORT MAP (
          x => x,
          y => y
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		x <= "00000000";
		wait for 5 ns;
		x <= "00000001";
		wait for 5 ns;
		x <= "00000010";
		wait for 5 ns;
		x <= "01111111";
		wait for 5 ns;
		x <= "10000000";
		wait for 5 ns;

      wait;
   end process;

END;
