----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:59:27 10/23/2012 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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

entity ctrl_unit is
    Port ( 
		   clock : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
		   start : in  STD_LOGIC;
		   A : in STD_LOGIC_VECTOR(7 downto 0);
		   B : in STD_LOGIC_VECTOR(7 downto 0);
           value : out  STD_LOGIC_VECTOR(31 downto 0);
           enable : out  STD_LOGIC_VECTOR(7 downto 0)
			  );
end ctrl_unit;

architecture Structural of ctrl_unit is

signal reset : std_logic;
signal prod : std_logic_vector(15 downto 0);

component Robertson_multiplier is
	Generic(N : integer := 8; M : integer :=8); --N numero bit moltiplicando, M numero bit moltiplicatore
    Port ( A : in  STD_LOGIC_VECTOR(N-1 downto 0); --moltiplicando
           B : in  STD_LOGIC_VECTOR(M-1 downto 0); --moltiplicatore
           START : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           P : out  STD_LOGIC_VECTOR(N+M-1 downto 0));
end component;

begin

reset <= not reset_n;
enable <= "00001111";
value(31 downto 16) <= (others => '0');
value(15 downto 0) <= prod;

moltiplicatore : Robertson_multiplier port map(
    CLK => clock, A => A, B => B, RST => reset, START => start, P => prod
);

end Structural;


