----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:33:19 01/11/2021 
-- Design Name: 
-- Module Name:    unita_controllo - Behavioral 
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

entity unita_controllo is
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
end unita_controllo;

architecture Behavioral of unita_controllo is
type state is (idle, check_N1, op, check_result);

signal current : state := idle;
begin
control: process(CLK)
variable Aint_N_1_N1 : STD_LOGIC_VECTOR(N-1 downto 0);
variable Bint_N_1_N1 : STD_LOGIC_VECTOR(M-1 downto 0);
variable M1int_NM_1_N1N1 : STD_LOGIC_VECTOR(N+M-1 downto 0);
variable M2int_NM_1_N1N1 : STD_LOGIC_VECTOR(N+M-1 downto 0);
begin
	if RST = '1' then
		current <= idle;
	elsif (CLK'event and CLK = '1') then
		case current is
			when idle =>
				if ( START = '1' ) then
					current <= check_N1; enable_check <= '0';RESET_OUT <= '0';ERROR_N1 <= '0'; START_OUT <= '0';
				else
					current <= idle; enable_check <= '0';RESET_OUT <= '0';ERROR_N1 <= '0'; START_OUT <= '0';
				end if;
			when check_N1 =>
				if ( ( N < N1 ) OR (M < N1) ) then
					current <= idle; RESET_OUT <= '1'; ERROR_N1 <= '1';START_OUT <= '0';
				else
					current <= op; RESET_OUT <= '0';ERROR_N1 <= '0';START_OUT <= '1';
					Aint_N_1_N1 := (others => A(N1-1));-- padding mantenendo il segno
					Aint <= Aint_N_1_N1(N-N1-1 downto 0) & A(N1-1 downto 0);
					Bint_N_1_N1 := (others => B(N1-1));-- padding mantenendo il segno
					Bint <= Bint_N_1_N1(M-N1-1 downto 0) & B(N1-1 downto 0);
					M1int_NM_1_N1N1 := (others => M1(N1+N1-1));-- padding mantenendo il segno
					M1int <= M1int_NM_1_N1N1(N+M-N1-N1-1 downto 0) & M1(N1+N1-1 downto 0);
					M2int_NM_1_N1N1 := (others => M2(N1+N1-1));-- padding mantenendo il segno
					M2int <= M2int_NM_1_N1N1(N+M-N1-N1-1 downto 0) & M2(N1+N1-1 downto 0);
				end if;
			when op =>
				if ( enable_result = '1' ) then
					current <= check_result; enable_check <= '0';RESET_OUT <= '0';ERROR_N1 <= '0';START_OUT <= '0';
				else
					current <= op; enable_check <= '0';RESET_OUT <= '0';ERROR_N1 <= '0';START_OUT <= '0';
				end if;
			when check_result =>
				current <= idle; enable_check <= '1';RESET_OUT <= '0';ERROR_N1 <= '0';START_OUT <= '0';
			when others => 
				current <= idle;
		end case;
	end if;
end process;

end Behavioral;

