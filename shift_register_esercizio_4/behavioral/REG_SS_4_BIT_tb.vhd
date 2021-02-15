--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:27:09 11/04/2020
-- Design Name:   
-- Module Name:   C:/Users/hp/OneDrive/XilinxISE-Workspace/Progetti/Progetto2/Esercizio4b/REG_SS_4_BIT_tb.vhd
-- Project Name:  Esercizio4b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: REG_SS_4_BIT
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
 
ENTITY REG_SS_4_BIT_tb IS
END REG_SS_4_BIT_tb;
 
ARCHITECTURE behavior OF REG_SS_4_BIT_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT REG_SS_4_BIT
    PORT(
         CLK : IN  std_logic;
         SHIFT : IN  std_logic_vector(1 downto 0);
         LOAD : IN  std_logic;
         A : IN  std_logic_vector(0 to 3);
         RESET : IN  std_logic;
         X : IN  std_logic;
         Y : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal SHIFT : std_logic_vector(1 downto 0) := (others => '0');
   signal LOAD : std_logic := '0';
   signal A : std_logic_vector(0 to 3) := (others => '0');
   signal RESET : std_logic := '1';
   signal X : std_logic := '0';

 	--Outputs
   signal Y : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REG_SS_4_BIT PORT MAP (
          CLK => CLK,
          SHIFT => SHIFT,
          LOAD => LOAD,
          A => A,
          RESET => RESET,
          X => X,
          Y => Y
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		-- insert stimulus here 

		RESET <= '0';
		SHIFT <= "11";
		X <= '1';
      wait for CLK_period*5;
		SHIFT <="00";
		RESET <='1';
		wait for CLK_period;
		RESET <='0';
		A <= "1001";
		LOAD <='1';
		wait for CLK_period;
		LOAD <='0';
		wait for CLK_period*4;
		assert Y='1'
		report "Errore"
		severity failure;
		 

      wait;
   end process;

END;
