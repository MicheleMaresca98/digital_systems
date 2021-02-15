--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:51:25 11/07/2020
-- Design Name:   
-- Module Name:   /home/marcofelix98/Architettura_dei_Sistemi_Digitali/my_projects/orologio_esercizio_3/contatore_N_bit_testbench.vhd
-- Project Name:  orologio_esercizio_3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: contatore_N_bit
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
 
ENTITY contatore_N_bit_testbench IS
END contatore_N_bit_testbench;
 
ARCHITECTURE behavior OF contatore_N_bit_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT contatore_N_bit
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         par : IN  std_logic_vector(2 downto 0);
         set : IN  std_logic;
         y : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal par : std_logic_vector(2 downto 0) := (others => '0');
   signal set : std_logic := '0';

 	--Outputs
   signal y : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: contatore_N_bit PORT MAP (
          clk => clk,
          rst => rst,
          par => par,
          set => set,
          y => y
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		wait for clk_period;
		rst <= '1';
		wait for clk_period;
		rst <= '0';
      wait for clk_period*10;
		rst <= '1';
		wait for clk_period;
		rst <= '0';
		wait for clk_period;
		par <= "110";
		set <= '1';
		wait for clk_period;
		set <= '0';

      wait;
   end process;

END;
