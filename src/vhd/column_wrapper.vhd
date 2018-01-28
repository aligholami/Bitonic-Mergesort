-- ========================================
-- [] File Name : column_wrapper.vhdl
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

entity ColumnWrapper is
    generic(CURRENT_DEPTH: INTEGER := 1);
    generic(NUM_INPUTS: INTEGER := 16);
    port(
        CC_INP_P: in BMS_BUS;
        CC_OUT_P: out BMS_BUS;
    );
end ColumnWrapper;

architecture RTL of ColumnWrapper is

    component CompColumn is
        generic(CURRENT_DEPTH: INTEGER := 1);
        generic(NUM_INPUTS: INTEGER := 16);
        port(
            CC_INP_P: in BMS_BUS;
            CC_OUT_P: out BMS_BUS;
        );
    end component CompColumn;
    
begin

end RTL;
