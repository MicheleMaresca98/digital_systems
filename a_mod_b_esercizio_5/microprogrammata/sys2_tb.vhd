--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:14:36 11/20/2020
-- Design Name:   
-- Module Name:   C:/Users/inggi/Desktop/Primo Anno Magistrale/Primo Semestre/Asdi/elaborato ASDi/Proggetti/progetto 5/micro_3/Logica_micropro/sys2_tb.vhd
-- Project Name:  Logica_micropro
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: system
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
 
ENTITY system_tb IS
END system_tb;
 
ARCHITECTURE behavior OF system_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT system
    PORT(
         buff_in : IN  std_logic_vector(7 downto 0);  
         buff_out : OUT  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         start : IN  std_logic;
			syn_out : out std_logic;
			ack_in : in std_logic;
			syn_in : in std_logic;
			ack_out : out std_logic;
         EOOP : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal buff_in : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal start : std_logic := '0';
   signal ack_in : std_logic := '0';
	signal syn_in : std_logic := '0';
 	--Outputs
	signal ack_out : std_logic; 
	signal buff_out : std_logic_vector(7 downto 0);
   signal syn_out : std_logic;
   signal EOOP : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: system PORT MAP (
          buff_in => buff_in,
          buff_out => buff_out,
          clk => clk,
          start => start,
			ack_in => ack_in,
			syn_in => syn_in,
			ack_out => ack_out,
			syn_out => syn_out,
          EOOP => EOOP
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
      -- hold reset state for 100 ns.
		
		start <= '1';
      wait for 100 ns;	
		
		start <= '0';

		wait for clk_period;
		
		syn_in <= '1';
		buff_in <= "00000111";
		wait until ack_out = '1'; -- and syn_out = '1'
		syn_in <= '0';
		ack_in <= '1';
		wait until ack_out = '0'; -- and syn_out = '0'
		ack_in <= '0';
		syn_in <= '1';
		buff_in <= "00000011";
		wait until ack_out = '1'; -- and syn_out = '1'		
		wait for 3* clk_period;
		ack_in <= '1';
		syn_in <= '0';
		wait for clk_period;
		ack_in <= '0';
		wait until syn_out = '1';
		syn_in <= '1';
		ack_in <= '1';
		wait until EOOP = '1' and ack_out = '1';

		wait for 2* clk_period;
	
      -- insert stimulus here 

      wait;
   end process;

END;
