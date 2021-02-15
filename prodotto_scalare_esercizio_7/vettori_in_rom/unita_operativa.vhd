----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:41:14 11/21/2020 
-- Design Name: 
-- Module Name:    unita_operativa - Behavioral 
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

entity unita_operativa is
    Port ( CLK : in  STD_LOGIC;
	EN : in  STD_LOGIC;
	RESET : in STD_LOGIC;
           A : in  STD_LOGIC_VECTOR(7 downto 0);
           B : in  STD_LOGIC_VECTOR(7 downto 0);
	AB : out STD_LOGIC_VECTOR(15 downto 0);
	abilitazione_risultato : in STD_LOGIC;
	reset_risultato : in STD_LOGIC
	  );
end unita_operativa;

architecture Structural of unita_operativa is
			
			signal ApiuB : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
			signal AperB : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
			signal S_Parziale : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
			signal P_Parziale : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
			signal Accumulatore : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
			
Component Adder is
		Port ( A : in  STD_LOGIC_VECTOR(15 downto 0);
		           B : in  STD_LOGIC_VECTOR(15 downto 0);
		           ApiuB : out  STD_LOGIC_VECTOR(15 downto 0)
			);
end component;

Component Moltiplicatore is
		Port ( A : in  STD_LOGIC_VECTOR(7 downto 0);
		           B : in  STD_LOGIC_VECTOR(7 downto 0);
		           AperB : out  STD_LOGIC_VECTOR(15 downto 0)
			);
end component;

Component Registro is
		Port ( CLK : in  STD_LOGIC;
		           EN: in  STD_LOGIC;
		           RESET : in  STD_LOGIC;
		           D : in  STD_LOGIC_VECTOR(15 downto 0);
		           Q : out  STD_LOGIC_VECTOR(15 downto 0)
			);
end component;

Begin
	
	Result: Registro
	Port map(CLK=>CLK,EN=>abilitazione_risultato,RESET=>reset_risultato,D=>ApiuB,Q=>AB);
	Somma_parziale: Registro
	Port map(CLK=>CLK,EN=>EN,RESET=>RESET,D=>ApiuB,Q=>S_Parziale);
	Prodotto_parziale: Registro
	Port map(CLK=>CLK,EN=>EN,RESET=>RESET,D=>AperB,Q=>P_Parziale);
	Prodotto: Moltiplicatore
	Port map(A=>A,B=>B,AperB=>AperB);
	Somma: Adder
	Port map(A=>P_Parziale,B=>S_Parziale,ApiuB=>ApiuB);
End Structural;




