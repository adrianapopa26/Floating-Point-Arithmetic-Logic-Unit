library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity StandardizingBlock is
    Port ( S : in STD_LOGIC;
           M : in STD_LOGIC_VECTOR (27 downto 0);
           E : in STD_LOGIC_VECTOR (7 downto 0);
           carryOut : in STD_LOGIC;
           operation : in STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (31 downto 0));
end StandardizingBlock;

architecture Behavioral of StandardizingBlock is

component ShiftLeft is
	port ( Min : in std_logic_vector(27 downto 0);	
		   shift : in std_logic_vector(7 downto 0);		
		   Mout : out std_logic_vector(27 downto 0));
end component;

component RoundBlock is
    Port ( Min : in STD_LOGIC_VECTOR (27 downto 0);
           Mout : out STD_LOGIC_VECTOR (22 downto 0));
end component;

signal zeroCount, Eaux : std_logic_vector(7 downto 0) := "00000000";
signal Mout2 : STD_LOGIC_VECTOR (27 downto 0) := "0000000000000000000000000000";
signal Mout1 : STD_LOGIC_VECTOR (22 downto 0) := "00000000000000000000000";

begin

    Zeroes: process(M)
    begin
        for i in 27 to 0 loop
            if M(i) = '0' then
                zeroCount <= zeroCount + '1';
            else 
                exit;
            end if;
       end loop;
    end process;
    
    Shift: ShiftLeft port map ( Min => M, 
                                shift => zeroCount, 
                                Mout => Mout2);
                                
    Round : RoundBlock port map (Min => Mout2, 
                                 Mout => Mout1);
    
    process(E, M, zeroCount)
    begin
         Eaux <= E - zeroCount + carryOut;
    end process;
    
    Result(31) <= S;
    Result(30 downto 23) <= Eaux; --when (Mout2 /= x"0000000" and operation = '1')or operation = '0' else x"00";
    Result(22 downto 0) <= Mout1(22 downto 0);
    
 end Behavioral;
