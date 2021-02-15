--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:19:08 01/03/2021
-- Design Name:   
-- Module Name:   C:/Users/inggi/Desktop/Primo Anno Magistrale/Primo Semestre/Asdi/elaborato ASDi/Esercizio10b/switch_8_tb.vhd
-- Project Name:  Esercizio10b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: switch_8
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
 
ENTITY switch_8_tb IS
END switch_8_tb;
 
ARCHITECTURE behavior OF switch_8_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT switch_8
    PORT(
         i0 : IN  std_logic_vector(2 downto 0);
         i1 : IN  std_logic_vector(2 downto 0);
         i2 : IN  std_logic_vector(2 downto 0);
         i3 : IN  std_logic_vector(2 downto 0);
         i4 : IN  std_logic_vector(2 downto 0);
         i5 : IN  std_logic_vector(2 downto 0);
         i6 : IN  std_logic_vector(2 downto 0);
         i7 : IN  std_logic_vector(2 downto 0);
         dest_i0 : IN  std_logic_vector(2 downto 0);
         dest_i1 : IN  std_logic_vector(2 downto 0);
         dest_i2 : IN  std_logic_vector(2 downto 0);
         dest_i3 : IN  std_logic_vector(2 downto 0);
         dest_i4 : IN  std_logic_vector(2 downto 0);
         dest_i5 : IN  std_logic_vector(2 downto 0);
         dest_i6 : IN  std_logic_vector(2 downto 0);
         dest_i7 : IN  std_logic_vector(2 downto 0);
         u0 : OUT  std_logic_vector(8 downto 0);
         u1 : OUT  std_logic_vector(8 downto 0);
         u2 : OUT  std_logic_vector(8 downto 0);
         u3 : OUT  std_logic_vector(8 downto 0);
         u4 : OUT  std_logic_vector(8 downto 0);
         u5 : OUT  std_logic_vector(8 downto 0);
         u6 : OUT  std_logic_vector(8 downto 0);
         u7 : OUT  std_logic_vector(8 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i0 : std_logic_vector(2 downto 0) := (others => '0');
   signal i1 : std_logic_vector(2 downto 0) := (others => '0');
   signal i2 : std_logic_vector(2 downto 0) := (others => '0');
   signal i3 : std_logic_vector(2 downto 0) := (others => '0');
   signal i4 : std_logic_vector(2 downto 0) := (others => '0');
   signal i5 : std_logic_vector(2 downto 0) := (others => '0');
   signal i6 : std_logic_vector(2 downto 0) := (others => '0');
   signal i7 : std_logic_vector(2 downto 0) := (others => '0');
   signal dest_i0 : std_logic_vector(2 downto 0) := (others => '0');
   signal dest_i1 : std_logic_vector(2 downto 0) := (others => '0');
   signal dest_i2 : std_logic_vector(2 downto 0) := (others => '0');
   signal dest_i3 : std_logic_vector(2 downto 0) := (others => '0');
   signal dest_i4 : std_logic_vector(2 downto 0) := (others => '0');
   signal dest_i5 : std_logic_vector(2 downto 0) := (others => '0');
   signal dest_i6 : std_logic_vector(2 downto 0) := (others => '0');
   signal dest_i7 : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal u0 : std_logic_vector(8 downto 0);
   signal u1 : std_logic_vector(8 downto 0);
   signal u2 : std_logic_vector(8 downto 0);
   signal u3 : std_logic_vector(8 downto 0);
   signal u4 : std_logic_vector(8 downto 0);
   signal u5 : std_logic_vector(8 downto 0);
   signal u6 : std_logic_vector(8 downto 0);
   signal u7 : std_logic_vector(8 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: switch_8 PORT MAP (
          i0 => i0,
          i1 => i1,
          i2 => i2,
          i3 => i3,
          i4 => i4,
          i5 => i5,
          i6 => i6,
          i7 => i7,
          dest_i0 => dest_i0,
          dest_i1 => dest_i1,
          dest_i2 => dest_i2,
          dest_i3 => dest_i3,
          dest_i4 => dest_i4,
          dest_i5 => dest_i5,
          dest_i6 => dest_i6,
          dest_i7 => dest_i7,
          u0 => u0,
          u1 => u1,
          u2 => u2,
          u3 => u3,
          u4 => u4,
          u5 => u5,
          u6 => u6,
          u7 => u7
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;	

		
		-- test due messaggi in parallelo nello stesso switch ma con due linee diverse
		i0 <= "100";
		i2 <= "111";
		dest_i0 <= "101";
		dest_i2 <= "110";		

		wait for 50 ns;

		assert u5 = "110100000";
--		report "errore nel passaggio di i0"
--		severity failure;
		assert u6 = "111001011";
--		report "errore nel passaggio di i2"
--		severity failure;

		-- reset delle linee abbassando l'enable
		i0(2) <='0';
		i2(2) <='0';

		wait for 100 ns;

		-- test collisione
		i5 <= "110";
		i7 <= "101";
		dest_i5 <= "100";
		dest_i7 <= "101";		
		
		wait for 10 ns;
		assert u4 = "110010110";
--		report "errore collisione"
--		severity failure;
		
		-- test un solo messaggio con un path verso lo 0
		wait for 50 ns;
		i7(2) <= '0';
		i5(2) <= '0';
		wait for 50 ns;
		i5 <= "110";
		dest_i5 <= "000";	
		wait for 100 ns;		

		i5(2) <= '0';
		
		-- test messaggi circolari
		wait for 50 ns;
		i0 <= "100";
		i1 <= "111";
		i2 <= "110";
		i3 <= "101";
		i4 <= "100";
		i5 <= "111";
		i6 <= "110";
		i7 <= "101";
		dest_i0 <= "001";
		dest_i1 <= "010";	
		dest_i2 <= "011";
		dest_i3 <= "100";	
		dest_i4 <= "101";
		dest_i5 <= "110";	
		dest_i6 <= "111";
		dest_i7 <= "000";	
		
		-- reset di tutte le linee
		wait for 50 ns;
		i0(2) <= '0';
		i1(2) <= '0';
		i2(2) <= '0';
		i3(2) <= '0';
		i4(2) <= '0';
		i5(2) <= '0';
		i6(2) <= '0';
		i7(2) <= '0';
		
		wait for 100 ns;	
		-- test in cui ognuno scrive a sè stesso
		i0 <= "100";
		i1 <= "111";
		i2 <= "110";
		i3 <= "101";
		i4 <= "100";
		i5 <= "111";
		i6 <= "110";
		i7 <= "101";
		dest_i0 <= "000";
		dest_i1 <= "001";	
		dest_i2 <= "010";
		dest_i3 <= "011";	
		dest_i4 <= "100";
		dest_i5 <= "101";	
		dest_i6 <= "110";
		dest_i7 <= "111";	
		
		wait for 50 ns;
		-- di nuovo test con messaggi circolari, senza effettuare il reset
		i0 <= "100";
		i1 <= "111";
		i2 <= "110";
		i3 <= "101";
		i4 <= "100";
		i5 <= "111";
		i6 <= "110";
		i7 <= "101";
		dest_i0 <= "001";
		dest_i1 <= "010";	
		dest_i2 <= "011";
		dest_i3 <= "100";	
		dest_i4 <= "101";
		dest_i5 <= "110";	
		dest_i6 <= "111";
		dest_i7 <= "000";	
		
      wait;
   end process;

END;
