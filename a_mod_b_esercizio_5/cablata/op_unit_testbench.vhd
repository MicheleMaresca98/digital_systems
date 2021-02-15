--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:43:11 11/11/2020
-- Design Name:   
-- Module Name:   /home/marcofelix98/Architettura_dei_Sistemi_Digitali/my_projects/a_mod_b_esercizio_5/op_unit_testbench.vhd
-- Project Name:  a_mod_b_esercizio_5
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: op_unit
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
 
ENTITY op_unit_testbench IS
END op_unit_testbench;
 
ARCHITECTURE behavior OF op_unit_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT op_unit
    PORT(
         x : IN  std_logic_vector(7 downto 0);
         sel_a : IN  std_logic;
         sel_b : IN  std_logic;
         en_a : IN  std_logic;
         en_b : IN  std_logic;
			rst : IN std_logic;
         cout : OUT  std_logic;
         y : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic_vector(7 downto 0) := (others => '0');
   signal sel_a : std_logic := '1';
   signal sel_b : std_logic := '1';
   signal en_a : std_logic := '0';
   signal en_b : std_logic := '0';
	signal rst : std_logic := '0';

 	--Outputs
   signal cout : std_logic := '0';
   signal y : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: op_unit PORT MAP (
          x => x,
          sel_a => sel_a,
          sel_b => sel_b,
          en_a => en_a,
          en_b => en_b,
          cout => cout,
          y => y,
			 rst => rst
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      
		x <= "00010100";
		wait for 5 ns;
		en_a <= '1';
		wait for 5 ns;
		en_a <= '0';
		x <= "00000011";
		wait for 5 ns;
		en_b <= '1';
		wait for 5 ns;
		en_b <= '0';
		assert y = "00010001";
		
		x <= "00000100";
		wait for 5 ns;
		en_a <= '1';
		wait for 5 ns;
		en_a <= '0';
		x <= "00000101";
		wait for 5 ns;
		en_b <= '1';
		wait for 5 ns;
		en_b <= '0';
		assert y = "11111111";

      wait;
   end process;

END;
