-- ========================================
-- [] File Name : comp_column.vhdl
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
use WORK.COMMON.ALL;

entity CompColumn is
    generic(CURRENT_DEPTH: INTEGER := 1);
    generic(NUM_INPUTS: INTEGER := 16);
    port(
        CC_INP_P: in BMS_BUS;
        CC_OUT_P: out BMS_BUS;
    );
end CompColumn;

architecture RTL of CompColumn is

    component Comparator is
        port(
            C_INP1_P: in STD_LOGIC_VECTOR(31 downto 0);
            C_INP2_P: in STD_LOGIC_VECTOR(31 downto 0);
            C_OUT1_P: out STD_LOGIC_VECTOR(31 downto 0);
            C_OUT2_P: out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component Comparator;

    signal STEP_S: INTEGER := 0;

begin
    COL_CONNECT: while(not(STEP_S = NUM_INPUTS >> 1)) generate
        COMP_GEN: Comparator port map(
            C_INP1_P => CC_INP_P(STEP_S),
            C_INP2_P => CC_INP_P(STEP_S + (2 << CURRENT_DEPTH)),
            C_OUT1_P => CC_OUT_P(STEP_S),
            C_OUT2_P => CC_OUT_P(STEP_S + (2 << CURRENT_DEPTH))
        );
        STEP_S <= STEP_S + 1;
end RTL;
