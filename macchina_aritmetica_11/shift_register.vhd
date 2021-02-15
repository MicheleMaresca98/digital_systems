----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:26:58 01/05/2021 
-- Design Name: 
-- Module Name:    shift_register - Structural 
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

entity shift_register is
	Generic(N : integer :=16);
    Port ( i_ser : in  STD_LOGIC;--ingresso seriale
           u_ser: out  STD_LOGIC;--uscita seriale
           load : in  STD_LOGIC;--abilitazione per caricamento parallelo dei flip flop
           i_par : in  STD_LOGIC_VECTOR(N-1 downto 0);--ingresso parallelo
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           SHIFT : in  STD_LOGIC;--abilitazione dei flip flop
			  u_par : out STD_LOGIC_VECTOR(N-1 downto 0)
			  );
end shift_register;

architecture Structural of shift_register is
component FLIP_FLOP_D_LOAD is
    Port ( CLK : in  STD_LOGIC;
			  EN : in STD_LOGIC;
			  RESET: in STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC;
			  I : in STD_LOGIC;--ingresso paralello
			  SET : in STD_LOGIC
			 );
end component;

signal T : STD_LOGIC_VECTOR (N-2 downto 0) := (others => '0');
signal u_ser_internal : STD_LOGIC := '0';

begin
--flip flop con bit più significativo
ff_0: FLIP_FLOP_D_LOAD
	Port map(CLK => CLK, EN => SHIFT, RESET => RST, D => i_ser, Q => T(N-2), I => i_par(N-1), SET => LOAD);

ff_1toN_2: for k in 1 to N-2 generate
	ff_i: FLIP_FLOP_D_LOAD
		Port map(CLK => CLK, EN => SHIFT, RESET => RST, D => T(N-1-k), Q => T(N-2-k), I => i_par(N-1-k), SET => LOAD);
end generate;
ff_N_1: FLIP_FLOP_D_LOAD
	Port map(CLK => CLK, EN => SHIFT, RESET => RST, D => T(0), Q => u_ser_internal, I => i_par(0), SET => LOAD);
	
u_par <= T&u_ser_internal;
u_ser <= u_ser_internal;
end Structural;

