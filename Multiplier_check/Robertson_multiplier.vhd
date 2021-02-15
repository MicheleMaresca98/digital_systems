----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:00:14 01/05/2021 
-- Design Name: 
-- Module Name:    Robertson_multiplier - Structural 
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
----------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use work.all;

entity Robertson_multiplier is
	Generic(N : integer := 8; M : integer :=8); --N numero bit moltiplicando, M numero bit moltiplicatore
    Port ( A : in  STD_LOGIC_VECTOR(N-1 downto 0); --moltiplicando
           B : in  STD_LOGIC_VECTOR(M-1 downto 0); --moltiplicatore
           START : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           P : out  STD_LOGIC_VECTOR(N+M-1 downto 0);
			  enable_result : out STD_LOGIC);
end Robertson_multiplier;

architecture Structural of Robertson_multiplier is

component control_unit is
	 Generic(N : integer := 8);
    Port ( q_0 : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           count_overflow : in  STD_LOGIC;
           start : in  STD_LOGIC;
           subtract : out  STD_LOGIC;
           count_in : out  STD_LOGIC;
			  enable_M : out STD_LOGIC;
			  enable_F : out STD_LOGIC;
			  load_A : out STD_LOGIC;
			  load_Q : out STD_LOGIC;
			  reset_regs : out STD_LOGIC;
			  enable_result : out STD_LOGIC;
           shift : out  STD_LOGIC;
			  sel_mux_f : out STD_LOGIC);
end component;


component mux_2_1 is
	Generic ( N : integer := 2 );
    Port ( i0 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           i1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
			  s : in STD_LOGIC;
           u : out  STD_LOGIC_VECTOR(N-1 downto 0));
end component;

component shift_register is
	Generic(N : integer :=16);
    Port ( i_ser : in  STD_LOGIC;--ingresso seriale
           u_ser : out  STD_LOGIC;--uscita seriale
           load : in  STD_LOGIC;--abilitazione per caricamento parallelo dei flip flop
           i_par : in  STD_LOGIC_VECTOR(N-1 downto 0);--ingresso parallelo
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           SHIFT : in  STD_LOGIC;--abilitazione dei flip flop
			  u_par : out STD_LOGIC_VECTOR(N-1 downto 0)
			  );
end component;

component adder_subtractor is
	Generic(N : integer := 8);
    Port ( op1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           op2 : in  STD_LOGIC_VECTOR(N-1 downto 0);
           subtract : in  STD_LOGIC;
           c_out : out  STD_LOGIC;
           res : out  STD_LOGIC_VECTOR(N-1 downto 0));
end component;

component Registro is
	Generic( N : integer := 8);
    Port ( CLK : in  STD_LOGIC;
           EN: in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR(N-1 downto 0);
           Q : out  STD_LOGIC_VECTOR(N-1 downto 0)
	 );
end component;

component counter is
	Generic(N : integer := 3; M : integer := 7);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  enable : in STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (N-1 downto 0);
			  overflow : out STD_LOGIC);
end component;

component FLIP_FLOP_D is
    Port ( CLK : in  STD_LOGIC;
			  EN : in STD_LOGIC;
			  RESET: in STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC
			 );
end component;

signal count_in, f_out, f_in, A_u_ser, load_prod_parz, subtract, load_moltiplicatore, 
en_F, enable_m, shift, count_overflow, enable_result_int, sel_mux_F, u_mux_F,
reset_F, reset_counter, reset_A, reset_regs : STD_LOGIC := '0';
signal M_out, prod_parz, A_u_par, mux_out, zero : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
signal Q_u_par : STD_LOGIC_VECTOR(M-1 downto 0) := (others => '0');
signal P_out : STD_LOGIC_VECTOR(N + M - 1 downto 0) := (others => '0');

begin

reset_F <= RST or reset_regs;
reset_A <= RST or reset_regs;
reset_counter <= RST or reset_regs;

cntrl_unit: control_unit 
	Generic map(N)
	Port map(
		q_0 => Q_u_par(0), clock => CLK, reset => RST, count_overflow => count_overflow,
		start => START, subtract => subtract, count_in => count_in, enable_M => enable_m,
		enable_F => en_F, load_A => load_prod_parz, load_Q => load_moltiplicatore,
		reset_regs => reset_regs, enable_result => enable_result_int, shift => shift,
		sel_mux_f => sel_mux_F);

-- registro contenente il moltiplicando
M_register: Registro
	Generic map(N)
    Port map(CLK => CLK, EN => enable_m, RESET => RST, D => A, Q => M_out);

MUX_moltiplicando: mux_2_1
	Generic map(N)
    Port map(i0 => zero, i1 => M_out, s => Q_u_par(0), u => mux_out);
	 
MUX_F: mux_2_1
	Generic map(1)
	Port map(i0(0) => f_out, i1(0) => A_u_par(N-1), s => sel_mux_F, u(0) => u_mux_F);
			 
A_shift_register: shift_register
	Generic map(N)
    Port map( i_ser => u_mux_F, u_ser => A_u_ser, load => load_prod_parz, i_par => prod_parz, u_par => A_u_par, 
           CLK => CLK, RST => reset_A, SHIFT => shift);
Q_shift_register: shift_register
	Generic map(M)
    Port map( i_ser => A_u_ser, load => load_moltiplicatore, i_par => B, u_par => Q_u_par,
           CLK => CLK, RST => RST, SHIFT => shift);

Parallel_Adder: entity work.adder_subtractor(Structural)
	Generic map(N)
    Port map(op1 => A_u_par, op2 => mux_out, subtract => subtract, res => prod_parz);

f_in <= ( (M_out(N-1) and Q_u_par(0)) or f_out );

F_register: FLIP_FLOP_D
    Port map( CLK => CLK, EN => en_F, RESET => reset_F, D => f_in, Q => f_out);

Contatore: counter
	Generic map(M, M-1)
    Port map(clock => CLK, reset => reset_counter, enable => count_in, overflow => count_overflow);
           
Risultato: Registro
	Generic map(N+M)
    Port map(CLK => CLK, EN => enable_result_int, RESET => RST, D => P_out, Q => P);
P_out <= A_u_par & Q_u_par;
enable_result <= enable_result_int;
end Structural;

