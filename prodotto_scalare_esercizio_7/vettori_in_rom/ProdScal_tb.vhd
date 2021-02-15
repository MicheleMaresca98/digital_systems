-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT ProdScal
          PORT(
                  CLK : IN std_logic;
                  START : IN std_logic;       
                  AB : OUT std_logic_vector(15 downto 0)
                  );
          END COMPONENT;

          SIGNAL START :  std_logic := '0';
			 SIGNAL CLK :  std_logic := '0';

          SIGNAL AB :  std_logic_vector(15 downto 0) := (others => '0');
          constant CLK_period : time := 10 ns;


  BEGIN

  -- Component Instantiation
          uut: ProdScal PORT MAP(
                  CLK => CLK,
                  START => START
          );



  --Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

  --  Test Bench Statements
     tb : PROCESS
     BEGIN

        wait for 100 ns; -- wait until global set/reset completes
			START <= '1';
			wait for CLK_period;
			START <= '0';
			wait for 4*CLK_period;
			--assert AB="0000000000011110"
			--report "errore0"
			--severity failure;
			wait for 4*CLK_period;
			--assert AB="0000000000110101"
			--report "errore1"
			--severity failure;
			wait for 4*CLK_period;
			--assert AB="0000000000111010"
			--report "errore2"
			--severity failure;
			wait for 7*CLK_period;
			assert AB="0000000000111010"
			report "errore2"
			severity failure;
       
			wait;
			-- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
