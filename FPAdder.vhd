library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FPAdder is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           operation : in STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (31 downto 0));
end FPAdder;

architecture Behavioral of FPAdder is

component Cases is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           enable : out STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component PreAdder is
     Port (A : in STD_LOGIC_VECTOR (31 downto 0);
          B : in STD_LOGIC_VECTOR (31 downto 0);
          SA : out STD_LOGIC;
          SB : out STD_LOGIC;
          Comp : out STD_LOGIC;
          Emax : out STD_LOGIC_VECTOR (7 downto 0);
          MAout : out STD_LOGIC_VECTOR (27 downto 0);
          MBout : out STD_LOGIC_VECTOR (27 downto 0));
end component;

component AdderBlock is
    Port ( operation : in STD_LOGIC;
           SA : in STD_LOGIC;
           SB : in STD_LOGIC;
           Comp : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (27 downto 0);
           B : in STD_LOGIC_VECTOR (27 downto 0);
           Result : out STD_LOGIC_VECTOR (27 downto 0);
           SO: out STD_LOGIC;
           carryOut: out STD_LOGIC);
end component;

component StandardizingBlock is
    Port ( S : in STD_LOGIC;
           M : in STD_LOGIC_VECTOR (27 downto 0);
           E : in STD_LOGIC_VECTOR (7 downto 0);
           carryOut : in STD_LOGIC;
           operation : in STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal enable, SA, SB, Comp, SO, carryOut: std_logic := '0';
signal auxResult, resultAdd : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
signal Emax : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
signal MAout, MBout, resultAdder : STD_LOGIC_VECTOR (27 downto 0) := "0000000000000000000000000000";
begin
    
    getCase : Cases port map (  A => A, 
                                B => B, 
                                enable => enable, 
                                Result => auxResult);
    
    preAdderComp : PreAdder port map ( A => A, 
                                        B => B, 
                                        SA => SA, 
                                        SB => SB, 
                                        Comp => Comp, 
                                        Emax => Emax, 
                                        MAout => MAout, 
                                        MBout => MBout);
    
    adderComp : AdderBlock port map (   operation => operation, 
                                        SA => SA, 
                                        SB => SB, 
                                        Comp => Comp, 
                                        A => MAout, 
                                        B => MBout, 
                                        Result => resultAdder, 
                                        SO => SO, 
                                        carryOut => carryOut);
    
    sandardizeComp: StandardizingBlock port map (   S => SO, 
                                                    M => resultAdder, 
                                                    E => Emax, 
                                                    carryOut => carryOut,
                                                    operation => operation,  
                                                    Result => resultAdd);
    
    Result <= auxResult when enable = '0' else
              resultAdd;
    
end Behavioral;
