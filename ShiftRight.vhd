library ieee;
use ieee.std_logic_1164.all;

entity ShiftRight is
	port ( Min : in std_logic_vector(27 downto 0);	
		   shift : in std_logic_vector(7 downto 0);		
		   Mout : out std_logic_vector(27 downto 0));
end ShiftRight;

architecture Behavioral of ShiftRight is

signal aux : std_logic_vector(27 downto 0) := "0000000000000000000000000000";
		
begin

    process(shift, Min)
    begin
        case shift is
            when "00000000" => aux <= Min;
            when "00000001" => aux <= "0" & Min(27 downto 1);
            when "00000010" => aux <= "00" & Min(27 downto 2);
            when "00000011" => aux <= "000" & Min(27 downto 3);
            when "00000100" => aux <= "0000" & Min(27 downto 4);
            when "00000101" => aux <= "00000" & Min(27 downto 5);
            when "00000110" => aux <= "000000" & Min(27 downto 6);
            when "00000111" => aux <= "0000000" & Min(27 downto 7);
            when "00001000" => aux <= "00000000" & Min(27 downto 8);
            when "00001001" => aux <= "000000000" & Min(27 downto 9);
            when "00001010" => aux <= "0000000000" & Min(27 downto 10);
            when "00001011" => aux <= "00000000000" & Min(27 downto 11);
            when "00001100" => aux <= "000000000000" & Min(27 downto 12);
            when "00001101" => aux <= "0000000000000" & Min(27 downto 13);
            when "00001110" => aux <= "00000000000000" & Min(27 downto 14);
            when "00001111" => aux <= "000000000000000" & Min(27 downto 15);
            when "00010000" => aux <= "0000000000000000" & Min(27 downto 16);
            when "00010001" => aux <= "00000000000000000" & Min(27 downto 17);
            when "00010010" => aux <= "000000000000000000" & Min(27 downto 18);
            when "00010011" => aux <= "0000000000000000000" & Min(27 downto 19);
            when "00010100" => aux <= "00000000000000000000" & Min(27 downto 20);
            when "00010101" => aux <= "000000000000000000000" & Min(27 downto 21);
            when "00010110" => aux <= "0000000000000000000000" & Min(27 downto 22);
            when "00010111" => aux <= "00000000000000000000000" & Min(27 downto 23);
            when "00011000" => aux <= "000000000000000000000000" & Min(27 downto 24);
            when "00011001" => aux <= "0000000000000000000000000" & Min(27 downto 25);
            when "00011010" => aux <= "00000000000000000000000000" & Min(27 downto 26);
            when "00011011" => aux <= "000000000000000000000000000" & Min(27);
            when others => aux <= "0000000000000000000000000000";
        end case;       
    end process;
    
    Mout <= aux;
    
end Behavioral;
