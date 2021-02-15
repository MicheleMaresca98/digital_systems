-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT decoder_2_4
          PORT(
                 x1 : in  STD_LOGIC;
					  x0 : in  STD_LOGIC;
					  s0 : in  STD_LOGIC;
					  yv : out  STD_LOGIC_VECTOR(3 downto 0));
          END COMPONENT;

			signal input : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
			signal control : STD_LOGIC := '0';
			signal output  : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
          

  BEGIN

  -- Component Instantiation
          uut: decoder_2_4 PORT MAP(
                  x0 => input(0),
                  x1 => input(1),
						s0 => control,
						yv => output
          );


  --  Test Bench Statements
     tb : PROCESS
     BEGIN

        wait for 100 ns; -- wait until global set/reset completes

        input(1) <= '1';
		  wait for 10 ns;
		  control <= '1';
		  wait for 20 ns;
		  input(0) <= '1';
		  wait for 20 ns;
		  input(1) <= '0';
		  wait for 20 ns;
		  input(0) <= '0';
		  wait for 50 ns;

        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
