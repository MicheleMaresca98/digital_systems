----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:34:48 01/02/2021 
-- Design Name: 
-- Module Name:    retepriorita - Dataflow 
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

entity retepriorita is
    Port ( en0 : in  STD_LOGIC;
           en1 : in  STD_LOGIC;
           en2 : in  STD_LOGIC;
           en3 : in  STD_LOGIC;
           u_prio : out  STD_LOGIC_VECTOR(1 downto 0));
end retepriorita;

architecture Dataflow of retepriorita is

begin
u_prio <= "00" when en0 = '1' else
			 "01" when en1 = '1' else
			 "10" when en2 = '1' else
			 "11" when en3 = '1' else
			 "--";
end Dataflow;

