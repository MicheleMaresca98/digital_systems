--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:15:01 11/11/2020
-- Design Name:   
-- Module Name:   /home/marcofelix98/Architettura_dei_Sistemi_Digitali/my_projects/a_mod_b_esercizio_5/a_mod_b_testbench.vhd
-- Project Name:  a_mod_b_esercizio_5
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: a_mod_b
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
 
ENTITY a_mod_b_testbench IS
END a_mod_b_testbench;
 
ARCHITECTURE behavior OF a_mod_b_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT a_mod_b
    PORT(
			  clk : in  STD_LOGIC;
			  start_a : in  STD_LOGIC;
			  start_b : in  STD_LOGIC;
			  ack : in STD_LOGIC;
			  rst : in STD_LOGIC;
			  x : in  STD_LOGIC_VECTOR(7 downto 0);
			  received_a : out  STD_LOGIC;
			  received_b : out  STD_LOGIC;
			  end_operation : out STD_LOGIC;
			  y : out  STD_LOGIC_VECTOR(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal start_a : std_logic := '0';
   signal start_b : std_logic := '0';
   signal x : std_logic_vector(7 downto 0) := (others => '0');
	signal ack : std_logic := '0';
	signal rst : std_logic := '0';

 	--Outputs
   signal received_a : std_logic := '0';
   signal received_b : std_logic := '0';
	signal end_operation : std_logic := '0';
   signal y : std_logic_vector(7 downto 0) := (others => '0');

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: a_mod_b PORT MAP (
          clk => clk,
          start_a => start_a,
          start_b => start_b,
          x => x,
          received_a => received_a,
          received_b => received_b,
          y => y,
			 ack => ack,
			 end_operation => end_operation,
			 rst => rst
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
      wait for clk_period*10;
		rst <= '1';
		wait for clk_period;
		rst <= '0';
		wait for clk_period;
		-- protocollo asincrono: non uso il clock ma gli eventi
		-- è stato comunque necessario fare la control unit sincrona perché next_state
		-- poteva essere schedulato più volte ed i segnali di controllo erano troppo
		-- brevi in durata
		x <= "01111111"; -- A=127
		wait for clk_period;
		start_a <= '1';
		wait until (received_a = '1');
		start_a <= '0';
		wait until (received_a = '0');
		
		x <= "00000100"; -- B=4 -> mi aspetto poi y=3 come resto modulo
		wait for clk_period;
		start_b <= '1';
		wait until (received_b = '1');
		start_b <= '0';
		wait until (received_b = '0');
		
		wait until (end_operation = '1');
		ack <= '1';
		wait until (end_operation = '0');
		ack <= '0';
		assert y = "00000011";

      wait;
   end process;

END;
