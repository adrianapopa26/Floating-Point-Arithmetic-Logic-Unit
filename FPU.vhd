library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FPU is
    Port ( clk: in std_logic;
           address1 : in STD_LOGIC_VECTOR (3 downto 0);
           address2 : in STD_LOGIC_VECTOR (3 downto 0);
           operation : in STD_LOGIC;
           segments : out STD_LOGIC_VECTOR (1 to 7);
           anode : out STD_LOGIC_VECTOR (3 downto 0);
           result2 : out STD_LOGIC_VECTOR (15 downto 0));
end FPU;

architecture Behavioral of FPU is
component ROM is
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
           A : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component FPAdder is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           operation : in STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component displ_7seg is
	port (  clk: in std_logic;
		    data : in std_logic_vector (15 downto 0);
		    sseg : out std_logic_vector (6 downto 0);
		    an : out std_logic_vector (3 downto 0));
end component;

signal A, B, result : STD_LOGIC_VECTOR (31 downto 0):= x"00000000";
signal result1 : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
begin
    
    Rom1: ROM port map (address => address1, 
                        A => A);
                        
    Rom2: ROM port map (address => address2, 
                        A => B);
                        
    FP: FPAdder port map (  A => A, 
                            B => B, 
                            operation => operation, 
                            Result => result);
    
    result1 <= result(31 downto 16);
    result2 <= result(15 downto 0);
    
    ssd: displ_7seg port map (  clk => clk,
                                data => result1 , 
                                sseg => segments, 
                                an => anode);
end Behavioral;
