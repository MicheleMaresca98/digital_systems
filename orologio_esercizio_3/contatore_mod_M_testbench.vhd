--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:56:53 11/07/2020
-- Design Name:   
-- Module Name:   /home/marcofelix98/Architettura_dei_Sistemi_Digitali/my_projects/orologio_esercizio_3/contatore_mod_M_testbench.vhd
-- Project Name:  orologio_esercizio_3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: contatore_mod_M
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
 
ENTITY contatore_mod_M_testbench IS
END contatore_mod_M_testbench;
 
ARCHITECTURE behavior OF contatore_mod_M_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT contatore_mod_M
	 Generic (n_bit : positive := 3; M : std_logic_vector := "111");
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         par : IN  std_logic_vector(n_bit-1 downto 0);
         set : IN  std_logic;
         y : OUT  std_logic_vector(n_bit-1 downto 0);
         overflow : OUT  std_logic
        );
    END COMPONENT;

	constant n : positive := 4;

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal par : std_logic_vector(n-1 downto 0) := (others => '0');
   signal set : std_logic := '0';

 	--Outputs
   signal y : std_logic_vector(n-1 downto 0) := (others => '0');
   signal overflow : std_logic := '0';

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: contatore_mod_M generic map(n_bit => n, M => "1010") PORT MAP (
          clk => clk,
          rst => rst,
          par => par,
          set => set,
          y => y,
          overflow => overflow
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
		par <= "0111";
		set <= '1';
		wait for clk_period;
		set <= '0';

      wait;
   end process;

END;
