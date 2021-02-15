--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:02:06 11/11/2020
-- Design Name:   
-- Module Name:   /home/marcofelix98/Architettura_dei_Sistemi_Digitali/my_projects/a_mod_b_esercizio_5/registro_mux_vect_testbench.vhd
-- Project Name:  a_mod_b_esercizio_5
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: registro_N_bit_multiplexed
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
 
ENTITY registro_mux_vect_testbench IS
END registro_mux_vect_testbench;
 
ARCHITECTURE behavior OF registro_mux_vect_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registro_N_bit_multiplexed
    PORT(
         sel : IN  std_logic;
         en : IN  std_logic;
         a : IN  std_logic_vector(7 downto 0);
         b : IN  std_logic_vector(7 downto 0);
         y : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sel : std_logic := '0';
   signal en : std_logic := '0';
   signal a : std_logic_vector(7 downto 0) := (others => '0');
   signal b : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal y : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registro_N_bit_multiplexed PORT MAP (
          sel => sel,
          en => en,
          a => a,
          b => b,
          y => y
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		a <= "10001000";
		b <= "00001111";
		wait for 10 ns;
		en <= '1';
		wait for 10 ns;
		en <= '0';
		wait for 5 ns;
		sel <= '1';
		wait for 5 ns;
		en <= '1';
		wait for 10 ns;
		en <= '0';
		sel <= '0';
		
      wait;
   end process;

END;
