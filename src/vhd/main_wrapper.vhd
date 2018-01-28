-- ========================================
-- [] File Name : main_wrapper.vhdl
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

entity MainWrapper is
    generic(NUM_INPUTS: INTEGER := 16);
    port(
        NETWORK_IN_P: in BMS_BUS;
        NETWORK_OUT_P: out BMS_BUS;
    );
end MainWrapper;

architecture RTL of MainWrapper is

    entity ColumnWrapper is
        generic(OUTER_DEPTH: INTEGER := 1);
        generic(NUM_INPUTS: INTEGER := 16);
        port(
            CW_INP_P: in BMS_BUS;
            CW_OUT_P: out BMS_BUS;
        );
    end ColumnWrapper;

    signal step: INTEGER := 1;
    signal CW_LIMIT: INTEGER := getCwLimit(NUM_INPUTS);

begin
    CW_GEN: while(not(step = CW_LIMIT + 1) generate
        -- CHECK THE INITIAL AND FINAL DEPTHS
        CHECK_SIDES: if(step = 1) generate

            -- GENERATE NEW SIGNALS
            CWSIGS_step: BMS_BUS;

            -- MOST RIGHT WRAPPER IN NETWORK
            CW_PM_1: ColumnWrapper
            generic map (
                OUTER_DEPTH => step,
                NUM_INPUTS => NUM_INPUTS
            )
            port map (
                CW_INP_P => CWSIGS_step,
                CW_OUT_P => NETWORK_OUT_P
            );

        elsif(step = CW_GEN) generate

            -- MOST LEFT WRAPPER IN NETWORK
            CW_PM_2: ColumnWrapper
            generic map (
                OUTER_DEPTH => step,
                NUM_INPUTS => NUM_INPUTS
            )
            port map (
                NETWORK_IN_P => CW_INP_P,
                CC_OUT_P => CWSIGS_(step-1)
            )

        else
            -- GENERATE NEW SIGNALS
            CWSIGS_step: BMS_BUS;

            -- INTERNAL WRAPPERS
            CW_PM_3: CompColumn
            generic map (
                OUTER_DEPTH => step,
                NUM_INPUTS => NUM_INPUTS
            )
            port map (
                CW_INP_P => CWSIGS_step,
                CW_OUT_P => CWSIGS_(step - 1)
            )
        end generate CHECK_SIDES;
end RTL;
