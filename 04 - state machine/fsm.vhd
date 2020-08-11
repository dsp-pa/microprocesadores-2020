
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fsm IS PORT (
    A : IN STD_LOGIC;
    O : OUT UNSIGNED(2 DOWNTO 0);
    CLK : IN STD_LOGIC
);
END fsm;

ARCHITECTURE FSMD OF FSM IS
    TYPE STATE_TYPE IS(
    START,
    S1,
    REPEAT,
    FINAL);
    SIGNAL STATE : STATE_TYPE := START;

BEGIN
    PROCESS (CLK)
    BEGIN
        IF (CLK'EVENT AND CLK = '1') THEN
            CASE STATE IS
                WHEN START =>
                    STATE <= S1;
                WHEN S1 =>
                    STATE <= REPEAT;
                WHEN REPEAT =>
                    IF (A = '1') THEN
                        STATE <= S1;
                    ELSE
                        STATE <= FINAL;
                    END IF;
                WHEN FINAL =>
                    STATE <= START;
            END CASE;
        END IF;
    END PROCESS;

    OP_PROCESS : PROCESS (STATE)
    BEGIN
        O_STATE : CASE STATE IS
            WHEN S1 =>
                O <= "111";
            WHEN OTHERS => O <= "000";
        END CASE O_STATE;
    END PROCESS;
END FSMD;