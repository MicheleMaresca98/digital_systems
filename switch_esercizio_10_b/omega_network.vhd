----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:21:08 01/03/2021 
-- Design Name: 
-- Module Name:    omega_network - Structural 
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

entity omega_network is
	Generic(N: integer :=6; M: integer :=3);
    Port ( i : in  STD_LOGIC_VECTOR(N*2**M - 1 downto 0);
           u : out  STD_LOGIC_VECTOR(N*2**M - 1 downto 0));
end omega_network;

architecture Structural of omega_network is
component node is
	Generic(N : integer := 6; M : integer := 3);
    Port ( i0 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           u0 : out  STD_LOGIC_VECTOR(N-1 downto 0);
           u1 : out  STD_LOGIC_VECTOR(N-1 downto 0));
end component;

constant h : integer := 2**M;
signal u_internal: STD_LOGIC_VECTOR(((N*2**M)*(M-1) - 1) downto 0);
begin
nodi_c1: for j in 0 to (h/2-1) generate
	nodo_j_0: node Generic map(N,M)
		Port map(i0 => i(((j+1)*N-1) downto (j*N)), 
					i1 => i(((h/2+j+1)*N-1) downto ((h/2+j)*N)), 
					u0 => u_internal(((2*j+1)*N-1) downto (2*j*N)),
					u1 => u_internal(((2*j+2)*N-1) downto ((2*j+1)*N)));
end generate;
nodi_r: for i in 1 to M - 2 generate
	nodi_c:for j in 0 to (h/2-1) generate
		nodo_j_i: node Generic map(N,M)
			Port map(i0 => u_internal(((j+1)*N-1 + (i-1)*(N*2**M)) downto (j*N) + (i-1)*(N*2**M)), 
						i1 => u_internal(((h/2+j+1)*N-1 + (i-1)*(N*2**M)) downto ((h/2+j)*N) + (i-1)*(N*2**M)), 
						u0 => u_internal(((2*j+1)*N-1 + (i)*(N*2**M)) downto (2*j*N) + (i)*(N*2**M)), 
						u1 => u_internal(((2*j+2)*N-1 + (i)*(N*2**M)) downto ((2*j+1)*N) + (i)*(N*2**M)));
	end generate;
end generate;
nodi_cM_1: for j in 0 to (h/2-1) generate
	nodo_j_M_1: node Generic map(N,M)
		Port map(i0 => u_internal(((j+1)*N-1 + (M-2)*(N*2**M)) downto (j*N) + (M-2)*(N*2**M)), 
					i1 => u_internal(((h/2+j+1)*N-1 + (M-2)*(N*2**M)) downto ((h/2+j)*N) + (M-2)*(N*2**M)), 
					u0 => u(((2*j+1)*N-1) downto (2*j*N)), 
					u1 => u(((2*j+2)*N-1) downto ((2*j+1)*N)));
end generate;
end Structural;

