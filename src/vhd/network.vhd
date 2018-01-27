-- ========================================
-- [] File Name : network.vhdl
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

entity BitonicSort is
    generic(NETWORK_BUS_WIDTH: INTEGER := 16);
    port(
        NET_INPUT_P: in BMS_BUS;
        NET_OUTPUT_P: out BMS_BUS;
        RESET_P: in STD_LOGIC;
        CLK_P: in STD_LOGIC;
    );
end BitonicSort;

architecture RTL of BitonicSort is

    component Comparator is
        port(
            INP1_P: in STD_LOGIC_VECTOR(31 downto 0);
            INP2_P: in STD_LOGIC_VECTOR(31 downto 0);
            OUT1_P: out STD_LOGIC_VECTOR(31 downto 0);
            OUT2_P: out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component Comparator;

    -- 2 ^ OUTER_DEPTH = NETWORK_BUS_WIDTH
    signal LAST_DEPTH: INTEGER := findOuterDepth(NETWORK_BUS_WIDTH);
    signal OUTER_DEPTH_S: INTEGER := LAST_DEPTH;

    -- HAS THE OUTER_DEPTH VALUE AT MOST
    signal INNER_DEPTH_S: INTEGER := 0;
 
begin

    OUTER_SEQ: while(not(OUTER_DEPTH_S = 0)) generate
        INNER_SEQ: while(not(INNER_DEPTH_S = OUTER_DEPTH_S)) generate
            COMP_SEQ: while(not(k = (NETWORK_BUS_WIDTH >> 1))) generate

                NET_OUT: if(OUTER_DEPTH_S = LAST_DEPTH and INNER_DEPTH_S = 0) generate
                    IN_SIG_k: SORT_ELEMENT;
                    IN_SIG_(k+1): SORT_ELEMENT;
                    COMP_PM_OUT: Comparator port map(IN_SIG_k, IN_SIG_(k+1), NET_OUTPUT_P(k), NET_OUTPUT_P(k+1))
                else
                    -- CREATE 4 SIGNALS FOR EACH NEW COMPARATOR
                    IN_SIG_k: SORT_ELEMENT;
                    IN_SIG_(k+1): SORT_ELEMENT;
                    OUT_SIG_k: SORT_ELEMENT;
                    OUT_SIG_(k+1): SORT_ELEMENT;

                    COMP_PM: Comparator port map(IN_SIG_k)

                COMP_PM_OUT: Comparator port map(SIG(k), PREV_S_LIST(k+1))
                SIG_k: SORT_ELEMENT;
                SIG_(k+1): SORT_ELEMENT;
                COMP_PM: Comparator port map(NET_INPUT_P(k), NET_INPUT_P(k+1), SIG_k, SIG_(k+1));
            end generate COMP_SEQ;

            NEXT_COMP_PM: Comparator port map()
        
end RTL;
 