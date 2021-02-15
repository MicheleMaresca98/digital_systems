--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:45:09 12/30/2020
-- Design Name:   
-- Module Name:   /home/marcofelix98/Architettura_dei_Sistemi_Digitali/my_projects/seriale_esercizio_9/uart_2_testbench.vhd
-- Project Name:  seriale_esercizio_9
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: uart_2
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
 
ENTITY uart_2_testbench IS
END uart_2_testbench;
 
ARCHITECTURE behavior OF uart_2_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT uart_2
    PORT(
         CLK : IN  std_logic;
         DBIN : IN  std_logic_vector(7 downto 0);
         DBOUT : OUT  std_logic_vector(7 downto 0);
         RST : IN  std_logic;
         WR : IN  std_logic;
         RD : IN std_logic;
         RDA : INOUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal DBIN : std_logic_vector(7 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal WR : std_logic := '0';
   signal RD : std_logic := '0';

	--BiDirs
   signal RDA : std_logic;

 	--Outputs
   signal DBOUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: uart_2 PORT MAP (
          CLK => CLK,
          DBIN => DBIN,
          DBOUT => DBOUT,
          RST => RST,
          WR => WR,
          RDA => RDA,
          RD => RD
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
		RST <= '1';
		wait for CLK_period;
        RST <= '0';
		DBIN <= "01000111"; -- 71
		WR <= '1';
		wait until RDA = '1';
		wait for CLK_period;
		RD <= '1';
		WR <= '0';
		assert DBOUT = "01000111";

      wait;
   end process;

END;
