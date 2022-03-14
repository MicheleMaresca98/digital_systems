----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:28:07 01/11/2021 
-- Design Name: 
-- Module Name:    unita_operativa - Structural 
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
	Generic(N : integer := 8; M: integer := 8);
    Port ( A : in  STD_LOGIC_VECTOR(N-1 downto 0);
           B : in  STD_LOGIC_VECTOR(M-1 downto 0);
           START : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           P : out  STD_LOGIC_VECTOR(N+M-1 downto 0);
           M1 : in  STD_LOGIC_VECTOR(N+M-1 downto 0);
           M2 : in  STD_LOGIC_VECTOR(N+M-1 downto 0);
           FLAG : out  STD_LOGIC;
			  ERROR : out STD_LOGIC;
           enable_check : in  STD_LOGIC;
			  enable_result : out STD_LOGIC);
end unita_operativa;

architecture Structural of unita_operativa is

component Robertson_multiplier is
	Generic(N : integer := 8; M : integer :=8); --N numero bit moltiplicando, M numero bit moltiplicatore
    Port ( A : in  STD_LOGIC_VECTOR(N-1 downto 0); --moltiplicando
           B : in  STD_LOGIC_VECTOR(M-1 downto 0); --moltiplicatore
           START : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           P : out  STD_LOGIC_VECTOR(N+M-1 downto 0);
			  enable_result : out STD_LOGIC);
end component;

component controllore_risultato is
	Generic(N : integer := 8; M : integer := 8);
    Port ( P : in  STD_LOGIC_VECTOR(N+M-1 downto 0);
           M1 : in  STD_LOGIC_VECTOR(N+M-1 downto 0);
           M2 : in  STD_LOGIC_VECTOR(N+M-1 downto 0);
           CLK : in  STD_LOGIC;
           enable_check : in  STD_LOGIC;
           FLAG : out  STD_LOGIC;
			  ERROR : out STD_LOGIC;
			  RST : in STD_LOGIC);
end component;

signal Pint : STD_LOGIC_VECTOR(N+M-1 downto 0);
begin
multiplier: Robertson_multiplier
	Generic map(N,M)
		Port map(A => A, B => B, START => START, CLK => CLK, RST => RST, P => Pint, enable_result => enable_result);

check: controllore_risultato
	Generic map(N,M)
		Port map(P => Pint, M1 => M1, M2 => M2, CLK => CLK, enable_check => enable_check, 
					FLAG => FLAG, ERROR => ERROR, RST => RST);
	
P <= Pint;
end Structural;

