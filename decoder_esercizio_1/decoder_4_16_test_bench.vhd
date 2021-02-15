--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:58:19 10/15/2020
-- Design Name:   
-- Module Name:   /home/marcofelix98/Architettura_dei_Sistemi_Digitali/my_projects/decoder_tree/decoder_4_16_test_bench.vhd
-- Project Name:  decoder_tree
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decoder_4_16
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
use work.all;

ENTITY decoder_4_16_test_bench IS
END decoder_4_16_test_bench;
 
ARCHITECTURE behavior OF decoder_4_16_test_bench IS 
 
    COMPONENT decoder_4_16
    PORT(
         x : IN  std_logic_vector(3 downto 0);
         s : IN  std_logic;
         y : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic_vector(3 downto 0) := (others => '0');
   signal s : std_logic := '1';

 	--Outputs
   signal y : std_logic_vector(15 downto 0) := (others => '0');
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.decoder_4_16(SemiSel) PORT MAP (
          x => x,
          s => s,
          y => y
        );

   -- Stimulus process
   stim_proc: process
   begin		
		
		x <= "0000";
		wait for 10 ns;
		assert y = "0000000000000001";
		
		x <= "0001";
		wait for 10 ns;
		assert y = "0000000000000010";
		
		x <= "0010";
		wait for 10 ns;
		assert y = "0000000000000100";
		
		x <= "0011";
		wait for 10 ns;
		assert y = "0000000000001000";
		
		x <= "0100";
		wait for 10 ns;
		assert y = "0000000000010000";
		
		x <= "0101";
		wait for 10 ns;
		assert y = "0000000000100000";
		
		x <= "0110";
		wait for 10 ns;
		assert y = "0000000001000000";
		
		x <= "0111";
		wait for 10 ns;
		assert y = "0000000010000000";
		
		x <= "1000";
		wait for 10 ns;
		assert y = "0000000100000000";
		
		x <= "1001";
		wait for 10 ns;
		assert y = "0000001000000000";
		
		x <= "1010";
		wait for 10 ns;
		assert y = "0000010000000000";
		
		x <= "1011";
		wait for 10 ns;
		assert y = "0000100000000000";
		
		x <= "1100";
		wait for 10 ns;
		assert y = "0001000000000000";
		
		x <= "1101";
		wait for 10 ns;
		assert y = "0010000000000000";
		
		x <= "1110";
		wait for 10 ns;
		assert y = "0100000000000000";
		
		x <= "1111";
		wait for 10 ns;
		assert y = "1000000000000000";

		wait;
   end process;

END;
