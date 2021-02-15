--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:58:25 11/06/2020
-- Design Name:   
-- Module Name:   C:/Users/hp/OneDrive/XilinxISE-Workspace/Progetti/Progetto4/Esercizio4a/MUX4_1_tb.vhd
-- Project Name:  Esercizio4a
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX4_1
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
 
ENTITY MUX4_1_tb IS
END MUX4_1_tb;
 
ARCHITECTURE behavior OF MUX4_1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX4_1
    PORT(
         I : IN  std_logic_vector(0 to 3);
         S : IN  std_logic_vector(1 downto 0);
         U : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal I : std_logic_vector(0 to 3) := (others => '0');
   signal S : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal U : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX4_1 PORT MAP (
          I => I,
          S => S,
          U => U
        );

   -- Clock process definitions
   --clock_process :process
   --begin
		--clock <= '0';
		--wait for clock_period/2;
		--clock <= '1';
		--wait for clock_period/2;
   --end process;
 

  stim_proc: process
		begin
		
		wait for 4 ns;
		
		--input = b0 b1 b2 b3
		--control = s1 s0
		
		I 	<= "0011";
		S <= "10"; 
		wait for 10 ns; -- b2 = 1  in uscita
		
		assert U = '1'
		report "errore0"
		severity failure;
		
		
		I 	<= "0111";
		S <= "00";
		wait for 10 ns; -- b0 = 0 in uscita
		
		assert U = '0'
		report "errore1"
		severity failure;
		
		
		I 	<= "0110";
		S <= "10";
		wait for 10 ns; -- b2 = 1 in uscita
		
		assert U = '1'
		report "errore2"
		severity failure;
		
		
		I 	<= "011H";
		S <= "11"; 
		wait for 10 ns; -- b3 = high in uscita
		
		assert U = 'H'
		report "errore3"
		severity failure;
		
		
		I 	<= "0L1H";
		S <= "01"; 
		wait for 10 ns; -- b1 = low in uscita
		
		assert U = 'L'
		report "errore4"
		severity failure;
		
		
		I 	<= "0W1H";
		S <= "01"; 
		wait for 20 ns; -- b1 = weak in uscita
		
		assert U = 'W'
		report "errore5"
		severity failure;
		
		wait;
		end process;
end; 

