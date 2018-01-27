-- ========================================
-- [] File Name : types.vhdl
--
-- [] Creation Date : January 2018
--
-- [] Author 1 : Ali Gholami (aligholami7596@gmail.com)
--
-- [] Author 2 : Mehdi Safaee(mxii1994@gmail.com)
-- ========================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Common is
    generic(BUS_WIDTH: INTEGER := 16);
    generic(ELEMENT_WIDTH: INTEGER := 32);

    type SORT_ELEMENT is STD_LOGIC_VECTOR(ELEMENT_WIDTH - 1 downto 0);
    type BMS_BUS is array(BUS_WIDTH - 1 downto 0) of SORT_ELEMENT;
end Common;