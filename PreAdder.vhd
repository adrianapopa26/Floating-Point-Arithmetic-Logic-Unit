library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PreAdder is
     Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
          B : in STD_LOGIC_VECTOR (31 downto 0);
          SA : out STD_LOGIC;
          SB : out STD_LOGIC;
          Comp : out STD_LOGIC;
          Emax : out STD_LOGIC_VECTOR (7 downto 0);
          MAout : out STD_LOGIC_VECTOR (27 downto 0);
          MBout : out STD_LOGIC_VECTOR (27 downto 0));
end PreAdder;

architecture Behavioral of PreAdder is

component CompareExponentBlock is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           SA : out STD_LOGIC;
           SB : out STD_LOGIC;
           Emax : out STD_LOGIC_VECTOR (7 downto 0);
           Mmax : out STD_LOGIC_VECTOR (22 downto 0);
           Mshift : out STD_LOGIC_VECTOR (22 downto 0);
           Dif : out STD_LOGIC_VECTOR (7 downto 0);
           Comp : out STD_LOGIC);
end component;

component ShiftRight is
	port ( Min : in std_logic_vector(27 downto 0);	
		   shift : in std_logic_vector(7 downto 0);		
		   Mout : out std_logic_vector(27 downto 0));
end component;

signal Mshift : STD_LOGIC_VECTOR (22 downto 0) := "00000000000000000000000";
signal MAaux : STD_LOGIC_VECTOR (22 downto 0) := "00000000000000000000000";
signal Maux : STD_LOGIC_VECTOR (27 downto 0):= "0000000000000000000000000000";
signal Mout : STD_LOGIC_VECTOR (27 downto 0):= "0000000000000000000000000000";
signal Dif : STD_LOGIC_VECTOR (7 downto 0) := "00000000";

begin

    CompareExponent : CompareExponentBlock port map (   A => A, 
                                                        B => B, 
                                                        SA => SA, 
                                                        SB => SB, 
                                                        Emax => Emax, 
                                                        Mmax => MAaux, 
                                                        Mshift => Mshift, 
                                                        Dif => Dif, 
                                                        Comp => Comp);
        
    Maux <= Mshift & "00000";
    Shift : ShiftRight port map (   Min => Maux, 
                                    shift => Dif, 
                                    Mout => Mout);
    
    MBout <= Mout;
    MAout <= MAaux & "00000";
       
end Behavioral;
