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
    generic(OUTER_DEPTH: INTEGER := 1);
    generic(NUM_INPUTS: INTEGER := 16);
    port(
        CW_INP_P: in BMS_BUS;
        CW_OUT_P: out BMS_BUS;
    );
end ColumnWrapper;

architecture RTL of ColumnWrapper is

    component CompColumn is
        generic(OUTER_DEPTH: INTEGER := 1);
        generic(INNER_DEPTH: INTEGER := 1);
        generic(NUM_INPUTS: INTEGER := 16);
        port(
            CC_INP_P: in BMS_BUS;
            CC_OUT_P: out BMS_BUS;
        );
    end component CompColumn;

    signal step: INTEGER := 1;
    signal COLS_LIMIT: INTEGER := getColsLimit(NUM_INPUTS, OUTER_DEPTH);

begin
    COL_GEN: while(not(step = COLS_LIMIT + 1) generate
        -- CHECK THE INITIAL AND FINAL DEPTHS
        CHECK_SIDES: if(step = 1) generate

            -- GENERATE NEW SIGNALS
            BETWEENSIGS_step: BMS_BUS;

            -- MOST RIGHT COLUMN IN WRAPPER
            COL_PM_1: CompColumn
            generic map (
                OUTER_DEPTH => OUTER_DEPTH,
                INNER_DEPTH => step,
                NUM_INPUTS => NUM_INPUTS
            )
            port map (
                CC_INP_P => BETWEENSIGS_step,
                CC_OUT_P => CW_OUT_P
            );

        elsif(step = COLS_LIMIT) generate

            -- MOST LEFT COLUMN IN WRAPPER
            COL_PM_2: CompColumn
            generic map (
                OUTER_DEPTH => OUTER_DEPTH,
                INNER_DEPTH => step,
                NUM_INPUTS => NUM_INPUTS
            )
            port map (
                CC_INP_P => CW_INP_P,
                CC_OUT_P => BETWEENSIGS_(step-1)
            )

        else
            -- GENERATE NEW SIGNALS
            BETWEENSIGS_step: BMS_BUS;

            -- INTERNAL COLUMNS
            COL_PM_3: CompColumn
            generic map (
                OUTER_DEPTH => OUTER_DEPTH,
                INNER_DEPTH => step,
                NUM_INPUTS => NUM_INPUTS
            )
            port map (
                CC_INP_P => BETWEENSIGS_step,
                CC_OUT_P => BETWEENSIGS_(step - 1)
            )
        end generate CHECK_SIDES;
end RTL;
