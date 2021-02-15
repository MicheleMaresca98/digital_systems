----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2020 19:14:38
-- Design Name: 
-- Module Name: division - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity translate_count is
port ( x : in std_logic_vector(5 downto 0);
    y : out std_logic_vector(7 downto 0));
end translate_count;

architecture Behavioral of translate_count is

begin
    process(x)
    variable var : integer range 0 to 63;
    variable count,i : integer range 0 to 64;
    variable b : integer;
    
    begin
    b := 10;
    i:=0; var:=to_integer(unsigned(x)); count:=0;
    for i in 63 downto 0 loop
        if (var>=b) then
            var := var-b;
            count:= count+1;
        else
            y <= std_logic_vector(to_unsigned(count, 4) & to_unsigned(var, 4));
            exit;
        end if;
    end loop;
    end process;
end Behavioral;
