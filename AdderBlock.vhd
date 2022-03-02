library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity AdderBlock is
    Port ( operation : in STD_LOGIC; 
           SA : in STD_LOGIC;
           SB : in STD_LOGIC;
           Comp : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (27 downto 0);
           B : in STD_LOGIC_VECTOR (27 downto 0);
           Result : out STD_LOGIC_VECTOR (27 downto 0);
           SO: out STD_LOGIC;
           carryOut: out STD_LOGIC);
end AdderBlock;

architecture Behavioral of AdderBlock is

component CLAadder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           S : out STD_LOGIC;
           Cout : out STD_LOGIC);
end component;

signal signAux, sign : std_logic;
signal Baux, aux , Saux : STD_LOGIC_VECTOR (27 downto 0) := "0000000000000000000000000000";
signal auxA, auxB : STD_LOGIC_VECTOR (27 downto 0) := "0000000000000000000000000000";

begin
    
    -- calculate the sign of output
    process( SA, SB, operation, Comp, A, B)
    begin
        if Comp = '1' then
            signAux <= SA;
        else
            signAux <= SB or operation; --xor
        end if;
        
        if SA = '1' and (SB xor operation) = '0' then 
            auxA <= B;
            auxB <= A;
        else
            auxA <= A;
            auxB <= B;
        end if;    
    end process;
    
    Add : for i in 0 to 27 generate
        Baux(i) <= auxB(i) xor operation;
        
        Sum0 : if i = 0 generate
            CLA1 : CLAadder port map (  A => auxA(i), 
                                        B => Baux(i), 
                                        Cin => operation, 
                                        S => Saux(i), 
                                        Cout => aux(i));
        end generate;
        
        Sumi : if i > 0 and i< 28 generate
            CLA2 : CLAadder port map (  A => auxA(i), 
                                        B => Baux(i), 
                                        Cin => aux(i - 1), 
                                        S => Saux(i), 
                                        Cout => aux(i));
        end generate;
          
    end generate;
    
    SO <= signAux;
    
    sign <= '1' when SA /= signAux else
            '0';
            
    Result <= (Saux xor X"FFFFFFF")+'1' when (sign and signAux) = '1' else
               Saux;-- Saux - x"2000000";
    carryOut <= '0' when ((SB xor operation) /= SA) else
                '1';

                
end Behavioral;
