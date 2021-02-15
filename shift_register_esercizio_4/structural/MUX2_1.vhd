----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:12:18 11/06/2020 
-- Design Name: 
-- Module Name:    MUX2_1 - Behavioral 
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

entity MUX2_1 is
    Port ( I : in  STD_LOGIC_VECTOR(0 to 1);
           S : in  STD_LOGIC;
           U : out  STD_LOGIC);
end MUX2_1;

architecture Dataflow of MUX2_1 is

begin
	U <= ((I(0) AND (NOT S)) OR (I(1) AND S));

end Dataflow;

