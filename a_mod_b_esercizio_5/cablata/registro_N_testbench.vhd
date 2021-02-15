--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:11:56 11/11/2020
-- Design Name:   
-- Module Name:   /home/marcofelix98/Architettura_dei_Sistemi_Digitali/my_projects/a_mod_b_esercizio_5/registro_N_testbench.vhd
-- Project Name:  a_mod_b_esercizio_5
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: registro_N_bit
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
 
ENTITY registro_N_testbench IS
END registro_N_testbench;
 
ARCHITECTURE behavior OF registro_N_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registro_N_bit
    PORT(
         par : IN  std_logic_vector(7 downto 0);
         en : IN  std_logic;
			rst : IN std_logic;
         y : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal par : std_logic_vector(7 downto 0) := (others => '0');
   signal en : std_logic := '0';
	signal rst : std_logic := '0';

 	--Outputs
   signal y : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registro_N_bit PORT MAP (
          par => par,
          en => en,
          y => y,
			 rst => rst
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		par <= "11110011";
		en <= '1';
		wait for 5 ns;
		en <= '0';
		wait for 5 ns;
		en <= '1';
		par <= "00001100";
		wait for 5 ns;
		en <= '0';
		par <= "11110011";
		
      wait;
   end process;

END;
