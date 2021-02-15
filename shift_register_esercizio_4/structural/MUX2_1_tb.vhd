--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:39:03 11/06/2020
-- Design Name:   
-- Module Name:   C:/Users/hp/OneDrive/XilinxISE-Workspace/Progetti/Progetto4/Esercizio4a/MUX2_1_tb.vhd
-- Project Name:  Esercizio4a
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX2_1
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
 
ENTITY MUX2_1_tb IS
END MUX2_1_tb;
 
ARCHITECTURE behavior OF MUX2_1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX2_1
    PORT(
         I : IN  std_logic_vector(0 to 1);
         S : IN  std_logic;
         U : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal I : std_logic_vector(0 to 1) := (others => '0');
   signal S : std_logic := '0';

 	--Outputs
   signal U : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX2_1 PORT MAP (
          I => I,
          S => S,
          U => U
        );
  
 

   -- Stimulus process
   stim_proc: process
   begin		
   wait for 10 ns;
	I <= "01";
	wait for 10 ns;
	S <= '1';
	wait for 5 ns;
	I <= "00";
	wait for 5 ns;
	I <= "10";
	wait for 5 ns;
	S <= '0';
	assert U = '0'
	report "errore0"
	severity failure;
   wait;
   end process;
	END;

