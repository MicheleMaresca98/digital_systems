----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:12:44 01/11/2021 
-- Design Name: 
-- Module Name:    system - Structural 
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

--Utilizzando il moltiplicatore/divisore implementato nel proprio elaborato, 
--progettarne una variante che operi su stringhe di lunghezza inferiore N1 e che 
--evidenzi se il risultato finale è compreso fra due estremi M1 ed M2, con N1, M1 
--ed M2 forniti come input.
--Si determini l'architettura complessiva del sistema, si fornisca l'implementazione 
--in VHDL, e si effettui la simulazione del componente con opportuno testbench.

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

entity system is
	Generic(N : integer := 8; M : integer := 8);
    Port ( M1 : in  STD_LOGIC_VECTOR(N+M-1 downto 0);
           M2 : in  STD_LOGIC_VECTOR(N+M-1 downto 0);
			  N1 : in integer; -- lunghezza in bit delle stringhe
           FLAG : out  STD_LOGIC;--flag risultato compreso tra M1 e M2
			  ERROR : out STD_LOGIC; -- Flag errore M2 < M1
			  ERROR_N1 : out STD_LOGIC; -- Flag errore N1 > N e N1 > M
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           START : in  STD_LOGIC;
           A : in  STD_LOGIC_VECTOR(N-1 downto 0);--Moltiplicando
           B : in  STD_LOGIC_VECTOR(M-1 downto 0);--Moltiplicatore
           P : out  STD_LOGIC_VECTOR(N+M-1 downto 0));--Prodotto
end system;

architecture Structural of system is

component unita_controllo is
    Generic(N : integer := 8; M : integer := 8);
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           enable_result : in  STD_LOGIC;
           enable_check : out  STD_LOGIC;
			  RESET_OUT : out STD_LOGIC;
			  START_OUT : out STD_LOGIC;
			  N1 : in integer;
			  START : in STD_LOGIC;
			  ERROR_N1 : out STD_LOGIC;
			  A : in  STD_LOGIC_VECTOR(N-1 downto 0);
           B : in  STD_LOGIC_VECTOR(M-1 downto 0); 
			  M1 : in  STD_LOGIC_VECTOR(N+M-1 downto 0);
           M2 : in  STD_LOGIC_VECTOR(N+M-1 downto 0);
			  Aint : out STD_LOGIC_VECTOR(N-1 downto 0);
			  Bint : out STD_LOGIC_VECTOR(M-1 downto 0);
			  M1int : out STD_LOGIC_VECTOR(N+M-1 downto 0);
			  M2int : out STD_LOGIC_VECTOR(N+M-1 downto 0)
			  );
end component;

component unita_operativa is
	Generic(N : integer := 8; M : integer := 8);
    Port ( A : in  STD_LOGIC_VECTOR(N-1 downto 0);
           B : in  STD_LOGIC_VECTOR(M-1 downto 0);
           START : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           P : out  STD_LOGIC_VECTOR(N+M-1 downto 0);
           M1 : in  STD_LOGIC_VECTOR(N+M-1 downto 0);
           M2 : in  STD_LOGIC_VECTOR(N+M-1 downto 0);
           FLAG : out  STD_LOGIC; -- Flag del controllo del risultato
			  ERROR : out  STD_LOGIC; -- Flag di errore alto se M1 > M2
           enable_check : in  STD_LOGIC;
			  enable_result : out STD_LOGIC);
end component;
signal enable_check, enable_result : STD_LOGIC := '0';
signal reset_int : STD_LOGIC := '0';
signal RESET_OUT, START_OUT : STD_LOGIC := '0';
signal Aint : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
signal Bint : STD_LOGIC_VECTOR(M-1 downto 0) := (others => '0');
signal M1int, M2int : STD_LOGIC_VECTOR(N+M-1 downto 0);


begin

reset_int <= RST or RESET_OUT;

UC: unita_controllo
	Port map(CLK => CLK, RST => RST, enable_result => enable_result, enable_check => enable_check,
				RESET_OUT => RESET_OUT, START_OUT => START_OUT, N1 => N1, START => START,
				ERROR_N1 => ERROR_N1, A => A, B => B, M1 => M1, M2 => M2, Aint => Aint, Bint => Bint, 
				M1int => M1int, M2int => M2int);
				
UO: unita_operativa
	Generic map(N,M)
		Port map(A => Aint, B => Bint, START => START_OUT, CLK => CLK, RST => reset_int, P => P, M1 => M1int, M2 => M2int, 
					FLAG => FLAG, ERROR => ERROR, enable_check => enable_check, enable_result => enable_result);
end Structural;

