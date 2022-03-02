library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--enable = enable/disable the adder block if needed/not needeed
--Result = output in the case there is a special case otherwise X"00000001"
entity Cases is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           enable : out STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (31 downto 0));
end Cases;

architecture Behavioral of Cases is

signal aux : STD_LOGIC_VECTOR (31 downto 0);

begin

    process( A, B)
    begin
            if A = X"00000000" then -- 0
                aux <= B;
            elsif A = X"80000000" then  -- -0
                aux <= B;
            elsif B = X"00000000" then --0
                aux <= A;
            elsif B = X"80000000" then -- -0
                aux <= A;
            elsif A = X"FF800000" then -- Inf
                if B = X"7F800000" then -- -Inf
                    aux <= X"7F800001";
                else 
                    aux <= A;
                end if;
            elsif A = X"7F800000" then -- -Inf
                if B = X"FF800000" then -- Inf
                    aux <= X"7F800001";
                else 
                    aux <= A;
                end if;
            elsif B = X"FF800000" then -- Inf
                if A = X"7F800000" then -- -Inf
                    aux <= X"7F800001";
                else 
                    aux <= B;
                end if;
            elsif B = X"7F800000" then -- -Inf
                if A = X"FF800000" then -- Inf
                    aux <= X"7F800001";
                else 
                    aux <= B;
                end if;
            elsif A(31 downto 23) = "111111111" then -- NaN
                aux <= X"FF800001";
            elsif B(31 downto 23) = "111111111" then 
                aux <= X"FF800001";
            elsif A(31 downto 23) = "011111111" then 
                aux <= X"7F800001";
            elsif B(31 downto 23) = "011111111" then 
                aux <= X"7F800001";
            else 
                aux <= X"00000001"; 
            end if;
    end process;
    
    enable <= '1' when aux = X"00000001" else '0';
    Result <= aux;
    
end Behavioral;