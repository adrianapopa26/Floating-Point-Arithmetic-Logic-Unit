library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RoundBlock is
    Port ( Min : in STD_LOGIC_VECTOR (27 downto 0);
           Mout : out STD_LOGIC_VECTOR (22 downto 0));
end RoundBlock;

architecture Behavioral of RoundBlock is

signal Maux :  STD_LOGIC_VECTOR (22 downto 0) := "00000000000000000000000";

begin
    
    process(Min)
    begin
        if Min(4 downto 0) >= "10000" then
            Maux <= Min(27 downto 5) + '1';
        else 
            Maux <= Min(27 downto 5);
        end if; 
    end process;
    
    Mout <= Maux;
end Behavioral;
