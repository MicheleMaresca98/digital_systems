----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:52:06 11/15/2020 
-- Design Name: 
-- Module Name:    system - Behavioral 
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

entity system is
    Port ( in_A1 : in  STD_LOGIC_VECTOR (15 downto 00);
           in_A2 : in  STD_LOGIC_VECTOR (15 downto 00);
           out_B1 : out  STD_LOGIC_VECTOR (15 downto 00);
           out_B2 : out  STD_LOGIC_VECTOR (15 downto 00));
end system;

architecture Behavioral of system is

	component SistemaA
		Port( in_A1 : in  STD_LOGIC_VECTOR (15 downto 00);
           in_A2 : in  STD_LOGIC_VECTOR (15 downto 00);
           in_data : out  STD_LOGIC_VECTOR (03 downto 00);
			   A_rdy : in STD_LOGIC;
			  gotA_rdy : out STD_LOGIC;
			  in_rdy : out STD_LOGIC;
			  in_rcvd : in STD_LOGIC);
	end component;
	
	component SistemaB
		Port ( out_data : in  STD_LOGIC_VECTOR (07 downto 00);
           out_B1 : out  STD_LOGIC_VECTOR (15 downto 00);
           out_B2 : out  STD_LOGIC_VECTOR (15 downto 00);
			  B_rdy : in STD_LOGIC;
			  gotB_rdy : out STD_LOGIC);
	end component;
	
	component fsmA
		Port( in_data : in  STD_LOGIC_VECTOR(03 downto 00);
           word_buffer : out  STD_LOGIC_VECTOR(07 downto 00);
           A_rdy : out  STD_LOGIC;
           gotA_rdy : in  STD_LOGIC;
           in_rcvd : out  STD_LOGIC;
           in_rdy : in  STD_LOGIC;
           buffer_picked : in  STD_LOGIC;
           buffer_full : out  STD_LOGIC);
	end component;
	
	component fsmB
		 Port ( word_buffer : in  STD_LOGIC_VECTOR(07 downto 00);
           out_data : out  STD_LOGIC_VECTOR(07 downto 00);
           buffer_full : in  STD_LOGIC;
           buffer_picked : out  STD_LOGIC;
           B_rdy : out  STD_LOGIC;
           gotB_rdy : in  STD_LOGIC);
	end component;
	
	signal in_data : STD_LOGIC_VECTOR (03 downto 00) := (others => '0');
	signal word_buffer : STD_LOGIC_VECTOR (07 downto 00) := (others => '0');
	signal out_data : STD_LOGIC_VECTOR (07 downto 00) := (others => '0');
	signal A_rdy :  STD_LOGIC :='0';
	signal gotA_rdy :  STD_LOGIC := '0';
   signal in_rdy :  STD_LOGIC := '0';
	signal in_rcvd :  STD_LOGIC := '0';
	signal B_rdy :  STD_LOGIC := '0';
	signal gotB_rdy :  STD_LOGIC := '0';
   signal buffer_picked :   STD_LOGIC := '0';
	signal buffer_full : STD_LOGIC := '0';
	
	
begin
	sysA: SistemaA
		Port map(in_A1 => in_A1, in_A2 => in_A2,in_data => in_data,
					A_rdy => A_rdy, gotA_rdy => gotA_rdy, in_rdy => in_rdy, in_rcvd => in_rcvd);
					
	sysB: SistemaB

		Port map(out_data => out_data, out_B1=>out_B1, out_B2 =>out_B2, B_rdy => B_rdy, gotB_rdy => gotB_rdy);
	
	U_C_fsmA: fsmA
		Port map(in_data => in_data,
           word_buffer => word_buffer, 
           A_rdy => A_rdy,
           gotA_rdy => gotA_rdy,
           in_rcvd => in_rcvd,
           in_rdy => in_rdy,
           buffer_picked => buffer_picked,
           buffer_full => buffer_full);	
			  
	U_C_fsmB: fsmB
		Port map(word_buffer => word_buffer,
           out_data => out_data,
           buffer_full => buffer_full,
			  buffer_picked => buffer_picked,
           B_rdy => B_rdy,
           gotB_rdy => gotB_rdy);

			  

end Behavioral;

