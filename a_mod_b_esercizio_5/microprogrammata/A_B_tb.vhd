--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:30:47 11/20/2020
-- Design Name:   
-- Module Name:   C:/Users/inggi/Desktop/Primo Anno Magistrale/Primo Semestre/Asdi/elaborato ASDi/Proggetti/progetto 5/micro_3/Logica_micropro/A_B_tb.vhd
-- Project Name:  Logica_micropro
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: A_B
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
 
ENTITY A_B_tb IS
END A_B_tb;
 
ARCHITECTURE behavior OF A_B_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT A_B
    PORT(
         clk : IN  std_logic;
         buff_out_in : IN  std_logic_vector(7 downto 0);
         buff_in_out : IN  std_logic_vector(7 downto 0);
         to_in : OUT  std_logic_vector(7 downto 0);
         to_out : OUT  std_logic_vector(7 downto 0);
         start : IN  std_logic;
         ack : IN  std_logic;
         syn : OUT  std_logic;
         EOOP_in : IN  std_logic;
         EOOP_out : OUT  std_logic;
         readya : OUT  std_logic;
         readyb : OUT  std_logic;
         gota : IN  std_logic;
         gotb : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal buff_out_in : std_logic_vector(7 downto 0) := (others => '0');
   signal buff_in_out : std_logic_vector(7 downto 0) := (others => '0');
   signal start : std_logic := '0';
   signal ack : std_logic := '0';
   signal EOOP_in : std_logic := '0';
   signal gota : std_logic := '0';
   signal gotb : std_logic := '0';

 	--Outputs
   signal to_in : std_logic_vector(7 downto 0);
   signal to_out : std_logic_vector(7 downto 0);
   signal syn : std_logic;
   signal EOOP_out : std_logic;
   signal readya : std_logic;
   signal readyb : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: A_B PORT MAP (
          clk => clk,
          buff_out_in => buff_out_in,
          buff_in_out => buff_in_out,
          to_in => to_in,
          to_out => to_out,
          start => start,
          ack => ack,
          syn => syn,
          EOOP_in => EOOP_in,
          EOOP_out => EOOP_out,
          readya => readya,
          readyb => readyb,
          gota => gota,
          gotb => gotb
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
		
		wait until syn = '1';
		buff_out_in <= "00000001";
		ack <= '1';
		
		wait until syn = '0';

		buff_out_in <= "00000010";
		wait for 3* clk_period;
		ack <= '0';
		wait for 2*clk_period;
		gotA <= '1';
		wait for clk_period;
		gotB <= '1';
		
		wait for 2* clk_period;
		buff_in_out <= "11111111";	
		EOOP_in <= '1';
		wait until EOOP_out = '1';
		
		wait for 2* clk_period;
		ack <= '1';
		
      -- insert stimulus here 

      wait;
   end process;

END;
