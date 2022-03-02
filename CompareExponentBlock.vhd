library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CompareExponentBlock is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           SA : out STD_LOGIC;
           SB : out STD_LOGIC;
           Emax : out STD_LOGIC_VECTOR (7 downto 0);
           Mmax : out STD_LOGIC_VECTOR (22 downto 0);
           Mshift : out STD_LOGIC_VECTOR (22 downto 0);
           Dif : out STD_LOGIC_VECTOR (7 downto 0);
           Comp : out STD_LOGIC);
end CompareExponentBlock;

architecture Behavioral of CompareExponentBlock is

signal EA, EB : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
signal MA, MB : STD_LOGIC_VECTOR(22 downto 0) := "00000000000000000000000";

begin

    SA <= A(31);
    EA <= A(30 downto 23);
    MA <= A(22 downto 0);
    
    EB <= B(30 downto 23);
    MB <= B(22 downto 0);
    SB <= B(31);
    
    process(EA, EB, MA, MB)
    begin
        if (EA >= EB or (EA = EB and MA >= MB)) then
            Comp <= '1';
            Emax <= EA;
            Dif <= EA - EB;
            MShift <= MB;
            Mmax <= MA;
        else
            Comp <= '0';
            Emax <= EB;
            Dif <= EB - EA;
            MShift <= MA;
            Mmax <= MB;
        end if;
    end process;
                      
end Behavioral;
