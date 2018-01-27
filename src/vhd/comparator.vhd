-- ========================================
-- [] File Name : comparator.vhdl
--
-- [] Creation Date : January 2018
--
-- [] Author 1 : Ali Gholami (aligholami7596@gmail.com)
--
-- [] Author 2 : Mehdi Safaee(mxii1994@gmail.com)
-- ========================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Comparator is
    port(
        INP1_P: in STD_LOGIC_VECTOR(31 downto 0);
        INP2_P: in STD_LOGIC_VECTOR(31 downto 0);
        OUT1_P: out STD_LOGIC_VECTOR(31 downto 0);
        OUT2_P: out STD_LOGIC_VECTOR(31 downto 0)
    );
end Comparator;

architecture RTL of Comparator is

begin
    SWAP_ELEMENTS: if(INP1_P > INP2_P) generate
        OUT1_P <= INP2_P;
        OUT2_P <= INP1_P;
    else
        OUT1_P <= INP1_P;
        OUT2_P <= INP2_P;
    end generate SWAP_ELEMENTS; 
end RTL;
