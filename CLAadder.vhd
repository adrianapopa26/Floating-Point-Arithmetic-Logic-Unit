library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CLAadder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           S : out STD_LOGIC;
           Cout : out STD_LOGIC);
end CLAadder;

architecture Behavioral of CLAadder is

begin

    Cout <= ((A and B) or (A and Cin) or (B and Cin));
    S <= A xor B xor Cin;
    
end Behavioral;
