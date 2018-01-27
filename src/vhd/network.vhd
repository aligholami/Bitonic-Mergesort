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

    OUTTER_SEQ: while(not(OUTER_DEPTH_S = 0)) generate

        INNER_SEQ: while(not(INNER_DEPTH_S = OUTER_DEPTH_S)) generate
            -- SIGNALS FOR THE INNER SEQUENCES 

            COMP_SEQ: while(not(k = (NETWORK_BUS_WIDTH >> 1))) generate

                -- CONNECTIONS FOR EACH COMPARATOR
                NET_OUT: if(OUTER_DEPTH_S = LAST_DEPTH and INNER_DEPTH_S = 0) generate
                    IN_SIG_k: SORT_ELEMENT;
                    IN_SIG_(k+1): SORT_ELEMENT;
                    COMP_PM_OUT: Comparator port map(IN_SIG_k, IN_SIG_(k+1), NET_OUTPUT_P(k), NET_OUTPUT_P(k+1));
                else
                    -- CREATE 4 SIGNALS FOR EACH NEW COMPARATOR
                    IN_SIG_k: SORT_ELEMENT;
                    IN_SIG_(k+INNER_DEPTH_S+1): SORT_ELEMENT;
                    OUT_SIG_k: SORT_ELEMENT;
                    OUT_SIG_(k+INNER_DEPTH_S+1): SORT_ELEMENT;

                    COMP_PM: Comparator port map(IN_SIG_k. IN_SIG_(k+INNER_DEPTH_S+1), OUT_SIG_k, OUT_SIG_(k+INNER_DEPTH_S+1));
                end generate NET_OUT;
            end generate COMP_SEQ;

            -- SIGNALS FOR THE INNER SEQUENCES
            INNER_DEPTH_S_LIST: BMS_BUS;

            -- CONNECT THE BETWEEN SIGNALS TO THE IN SIGNALS CREATED ON COMP_SEQ
            CON_SEQ_SIGNALS: for i in 0 to NETWORK_BUS_WIDTH generate
                IN_SIG_i <= INNER_DEPTH_S_LIST(i);
            end generate CON_SEQ_SIGNALS;
        end generate INNER_SEQ;

        -- SIGNALS FOR THE OUTTER SEQUENCES
        OUTTER_DEPTH_S_LIST: BMS_BUS;

        

            

            NEXT_COMP_PM: Comparator port map()
        
end RTL;
 