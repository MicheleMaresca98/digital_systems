--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:10:25 11/08/2020
-- Design Name:   
-- Module Name:   /home/marcofelix98/Architettura_dei_Sistemi_Digitali/my_projects/orologio_esercizio_3/orologio_testbench.vhd
-- Project Name:  orologio_esercizio_3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: orologio
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
 
ENTITY orologio_testbench IS
END orologio_testbench;
 
ARCHITECTURE behavior OF orologio_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT orologio
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         set : IN  std_logic;
         set_s : IN  std_logic_vector(5 downto 0);
         set_m : IN  std_logic_vector(5 downto 0);
         set_h : IN  std_logic_vector(4 downto 0);
         s : OUT  std_logic_vector(5 downto 0);
         m : OUT  std_logic_vector(5 downto 0);
         h : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal set : std_logic := '0';
   signal set_s : std_logic_vector(5 downto 0) := (others => '0');
   signal set_m : std_logic_vector(5 downto 0) := (others => '0');
   signal set_h : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal s : std_logic_vector(5 downto 0);
   signal m : std_logic_vector(5 downto 0);
   signal h : std_logic_vector(4 downto 0);

   -- 50 MHz di frequenza -> 20 ns di periodo
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: orologio PORT MAP (
          clk => clk,
          rst => rst,
          set => set,
          set_s => set_s,
          set_m => set_m,
          set_h => set_h,
          s => s,
          m => m,
          h => h
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
		-- NOTA: simulare usando il frontend modulo 5 al posto di 50 milioni;
		-- simulare per un tempo di 10 us
		wait for clk_period;
		rst <= '1';
		wait for clk_period;
		rst <= '0';
		wait for clk_period*300;
		set_s <= "111000";
		set_m <= "011110";
		set_h <= "01100";
		set <= '1';
		wait for clk_period*3;
		set <= '0';
--      wait for clk_period*100000000; -- 2 secondi
--		rst <= '1';
--		wait for clk_period;
--		-- setto: ora 12, minuto 30, secondo 56
--		set_s <= "111000";
--		set_m <= "011110";
--		set_h <= "01100";
--		set <= '1';
--		wait for clk_period;
--		set <= '0';
      wait;
--		wait for clk_period*250000000; -- 5 secondi
   end process;

END;
