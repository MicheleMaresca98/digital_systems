--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:56:52 01/02/2021
-- Design Name:   
-- Module Name:   C:/Users/hp/OneDrive/XilinxISE-Workspace/Progetti/Progetto10/Esercizio10/omega_network_4_tb.vhd
-- Project Name:  Esercizio10
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: omega_network_4
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
use work.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY omega_network_4_tb IS
END omega_network_4_tb;
 
ARCHITECTURE behavior OF omega_network_4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT omega_network_4
    PORT(
         i0 : IN  std_logic_vector(1 downto 0);
         i1 : IN  std_logic_vector(1 downto 0);
         i2 : IN  std_logic_vector(1 downto 0);
         i3 : IN  std_logic_vector(1 downto 0);
         en_i0 : IN  std_logic;
         en_i1 : IN  std_logic;
         en_i2 : IN  std_logic;
         en_i3 : IN  std_logic;
         dest_i0 : IN  std_logic_vector(1 downto 0);
         dest_i1 : IN  std_logic_vector(1 downto 0);
         dest_i2 : IN  std_logic_vector(1 downto 0);
         dest_i3 : IN  std_logic_vector(1 downto 0);
         u0 : OUT  std_logic_vector(1 downto 0);
         u1 : OUT  std_logic_vector(1 downto 0);
         u2 : OUT  std_logic_vector(1 downto 0);
         u3 : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i0 : std_logic_vector(1 downto 0) := (others => '0');
   signal i1 : std_logic_vector(1 downto 0) := (others => '0');
   signal i2 : std_logic_vector(1 downto 0) := (others => '0');
   signal i3 : std_logic_vector(1 downto 0) := (others => '0');
   signal en_i0 : std_logic := '0';
   signal en_i1 : std_logic := '0';
   signal en_i2 : std_logic := '0';
   signal en_i3 : std_logic := '0';
   signal dest_i0 : std_logic_vector(1 downto 0) := (others => '0');
   signal dest_i1 : std_logic_vector(1 downto 0) := (others => '0');
   signal dest_i2 : std_logic_vector(1 downto 0) := (others => '0');
   signal dest_i3 : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal u0 : std_logic_vector(1 downto 0);
   signal u1 : std_logic_vector(1 downto 0);
   signal u2 : std_logic_vector(1 downto 0);
   signal u3 : std_logic_vector(1 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: omega_network_4 PORT MAP (
          i0 => i0,
          i1 => i1,
          i2 => i2,
          i3 => i3,
          en_i0 => en_i0,
          en_i1 => en_i1,
          en_i2 => en_i2,
          en_i3 => en_i3,
          dest_i0 => dest_i0,
          dest_i1 => dest_i1,
          dest_i2 => dest_i2,
          dest_i3 => dest_i3,
          u0 => u0,
          u1 => u1,
          u2 => u2,
          u3 => u3
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		i0 <= "00";
		i1 <= "01";
		i2 <= "10";
		i3 <= "11";
		dest_i0 <= "00";
		dest_i1 <= "11";
		dest_i2 <= "10";
		dest_i3 <= "01";
      wait for 50 ns;	
		en_i1 <= '1';
		en_i2 <= '1';
		en_i3 <= '1';
		wait for 50 ns;
		assert u3 = "01";
		report "errore0"
		severity failure;
		

      -- insert stimulus here 
		wait;
      wait;
   end process;

END;
