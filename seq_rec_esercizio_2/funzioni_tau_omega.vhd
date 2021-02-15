----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:23:15 10/30/2020 
-- Design Name: 
-- Module Name:    funzioni_tau_omega - Behavioral 
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

entity funzioni_tau_omega is
    Port ( q : in  STD_LOGIC_VECTOR(2 downto 0);
			  i : in  STD_LOGIC;
           q_next : out  STD_LOGIC_VECTOR(2 downto 0);
           y : out  STD_LOGIC );
end funzioni_tau_omega;

architecture Dataflow of funzioni_tau_omega is

begin

y <= q(2) and (not i);
q_next(0) <= ((not q(1)) and q(0) and i) or (((not q(2)) and (not q(0))) and (((not q(1)) and i) or ((not i) and q(1)))) or (q(2) and (not i));
q_next(1) <= (q(2) and ((not i) or q(0))) or (q(1) and (not q(0)) and (not i)) or ((not q(1)) and q(0));
q_next(2) <= (q(1) or (q(2) and (not q(0)))) and i;

end Dataflow;

