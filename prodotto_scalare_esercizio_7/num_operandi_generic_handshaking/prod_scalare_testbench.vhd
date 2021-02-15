--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:45:30 11/21/2020
-- Design Name:   
-- Module Name:   /home/marcofelix98/Architettura_dei_Sistemi_Digitali/my_projects/prodotto_scalare_esercizio_7/prod_scalare_testbench.vhd
-- Project Name:  prodotto_scalare_esercizio_7
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: prodotto_scalare
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
USE ieee.numeric_std.ALL;
 
ENTITY prod_scalare_testbench IS
END prod_scalare_testbench;
 
ARCHITECTURE behavior OF prod_scalare_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT prodotto_scalare
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         start : IN  std_logic;
         M : IN  unsigned(7 downto 0);
         a : IN  unsigned(7 downto 0);
         b : IN  unsigned(7 downto 0);
         ack_end_op : IN  std_logic;
         ack : OUT  std_logic;
         end_op : OUT  std_logic;
         y : OUT  unsigned(23 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal start : std_logic := '0';
   signal M : unsigned(7 downto 0) := (others => '0');
   signal a : unsigned(7 downto 0) := (others => '0');
   signal b : unsigned(7 downto 0) := (others => '0');
   signal ack_end_op : std_logic := '0';

 	--Outputs
   signal ack : std_logic;
   signal end_op : std_logic;
   signal y : unsigned(23 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: prodotto_scalare PORT MAP (
          clk => clk,
          rst => rst,
          start => start,
          M => M,
          a => a,
          b => b,
          ack_end_op => ack_end_op,
          ack => ack,
          end_op => end_op,
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
 

   -- Processo client (produttore)
   produttore: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		rst <= '1';
      wait for clk_period;
		rst <= '0';
      wait for clk_period;
		
		M <= to_unsigned(3, 8);
		start <= '1';
		-- il protocollo è sincrono ma ci vuole una sincronizzazione di fase iniziale
		wait until (ack = '1'); 
		start <= '0';
		wait for clk_period;
		a <= to_unsigned(2, 8);
		b <= to_unsigned(4, 8);
		wait for clk_period;
		a <= to_unsigned(10, 8);
		b <= to_unsigned(2, 8);
		wait for clk_period;
		a <= to_unsigned(7, 8);
		b <= to_unsigned(4, 8);
		wait until (end_op = '1'); -- il protocollo è semisincrono
		ack_end_op <= '1';
		assert (y = to_unsigned(56, 24));
		wait until (end_op = '0'); -- il protocollo è semisincrono
		ack_end_op <= '0';
		wait for clk_period;
		
		M <= to_unsigned(5, 8);
		start <= '1';
		wait until (ack = '1');
		start <= '0';
		wait for clk_period;
		a <= to_unsigned(60, 8);
		b <= to_unsigned(5, 8);
		wait for clk_period;
		a <= to_unsigned(0, 8);
		b <= to_unsigned(200, 8);
		wait for clk_period;
		a <= to_unsigned(10, 8);
		b <= to_unsigned(10, 8);
		wait for clk_period;
		a <= to_unsigned(2, 8);
		b <= to_unsigned(100, 8);
		wait for clk_period;
		a <= to_unsigned(4, 8);
		b <= to_unsigned(200, 8);
		wait until (end_op = '1');
		ack_end_op <= '1';
		assert (y = to_unsigned(1400, 24));
		wait until (end_op = '0');
		ack_end_op <= '0';

      wait;
   end process;

END;
