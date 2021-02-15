----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:46:30 11/06/2020 
-- Design Name: 
-- Module Name:    REG_SS_4_BIT - Structural 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REG_SS_4_BIT is
	 generic(N: integer :=4);
    Port ( CLK : in  STD_LOGIC;
           SHIFT : in  STD_LOGIC_VECTOR(1 downto 0);
           LOAD : in  STD_LOGIC;
           A : in  STD_LOGIC_VECTOR(0 to N-1);
           RESET : in  STD_LOGIC;
           X : in  STD_LOGIC;
           Y : out  STD_LOGIC);
end REG_SS_4_BIT;

architecture Structural of REG_SS_4_BIT is

	signal Tp : STD_LOGIC_VECTOR(0 to N-1) := (others => '0');
	signal T : STD_LOGIC_VECTOR(0 to N-1) := (others => '0');
	--signal Yinternal : STD_LOGIC;
	component MUX4_1
	port( I : in  STD_LOGIC_VECTOR(0 to 3);
         S : in  STD_LOGIC_VECTOR(1 downto 0);
         U : out  STD_LOGIC
		);
	end component;
	
	component FF_D
	port(	  CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
			  A : in STD_LOGIC;
			  LOAD : in STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC
		);
	end component;
	
	component REGISTRO
	port( 	CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           y : in  STD_LOGIC;
           U : out  STD_LOGIC
			 );
	end component;
	
begin
	mux0: MUX4_1
	Port map( I(0) => '0',
				 I(1) => Tp(1),
				 I(2) => Tp(N-1),
				 I(3) => X,
				 S => SHIFT,
				 U =>T(0)
				 );
--	mux1: MUX4_1
--	Port map( I(0) => Tp(0),
--				 I(1) => Tp(2),
--				 I(2) => Tp(0),
--				 I(3) => Tp(0),
--				 S =>SHIFT,
--				 U =>T(1)
--				 );
--	mux2: MUX4_1
--	Port map( I(0) => Tp(1),
--				 I(1) => Tp(3),
--				 I(2) => Tp(1),
--				 I(3) => Tp(1),
--				 S => SHIFT,
--				 U =>T(2)
--				 );
	mux1to2: FOR j IN 1 TO N-2 GENERATE
	m: MUX4_1
	Port map( I(0) => Tp(j-1),
				 I(1) => Tp(j+1),
				 I(2) => Tp(j-1),
				 I(3) => Tp(j-1),
				 S => SHIFT,
				 U =>T(j)
				 );
	END GENERATE;
	
	
	muxN_1: MUX4_1
	Port map( I(0) => Tp(N-2),
				 I(1) => '0',
				 I(2) => Tp(N-2),
				 I(3) => Tp(N-2),
				 S => SHIFT,
				 U =>T(N-1)
				 );
				 
	ff_t0toN_2: FOR k IN 0 TO N-2 GENERATE
	ffd: FF_D
	Port map(   CLK =>CLK,
					RESET => RESET,
					A => A(N-1-k),
					LOAD => LOAD,
					D =>T(k),
					Q =>Tp(k)
				 );
	END GENERATE;
				 
--	ff_t0: FF_T
--	Port map(	  CLK =>CLK,
--           RESET => RESET,
--				 A => A(0),
--				 LOAD => LOAD,
--           T =>T(0),
--           Q =>Tp(0)
--		);
--	ff_t1: FF_T
--	Port map(	  CLK =>CLK,
--           RESET => RESET,
--				 A => A(1),
--				 LOAD => LOAD,
--           T =>T(1),
--           Q =>Tp(1)
--		);
--	ff_t2: FF_T
--	Port map(	  CLK =>CLK,
--           RESET => RESET,
--				 A => A(2),
--				 LOAD => LOAD,
--           T =>T(2),
--           Q =>Tp(2)
--		);


	ff_dN_1: FF_D
	Port map(	  CLK =>CLK,
           RESET => RESET,
			  A => A(0),
			  LOAD => LOAD,
           D =>T(N-1),
           Q =>Tp(N-1)
		);
		
	REG: REGISTRO
	port map( 	CLK => CLK,
					RESET => RESET,
					y => Tp(N-1),
					U =>y
			 );
		

end Structural;

