LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RAM_4BITS IS
    GENERIC (
        ADDR_WIDTH : INTEGER := 2;
        DATA_WIDTH : INTEGER := 4
    );

    PORT (
        CLK : IN std_logic;
        WE : IN std_logic;
        ADDR : IN UNSIGNED(ADDR_WIDTH - 1 DOWNTO 0);
        DATA_IN : IN UNSIGNED(DATA_WIDTH - 1 DOWNTO 0);
        DATA_OUT : OUT UNSIGNED(DATA_WIDTH - 1 DOWNTO 0)
    );
END RAM_4BITS;

ARCHITECTURE arch OF RAM_4BITS IS
    TYPE RAM_TYPE IS ARRAY (0 TO (2 ** ADDR_WIDTH - 1))
    OF UNSIGNED (DATA_WIDTH - 1 DOWNTO 0);

    SIGNAL RAM : RAM_TYPE := (
    "1000", "0111", "1010", "0000"
    );

BEGIN
    PROCESS (CLK)
    BEGIN
        IF (CLK'event AND CLK = '1') THEN
            IF (we = '1') THEN
                RAM(to_integer(unsigned(addr))) <= DATA_IN;
            END IF;
        END IF;
    END PROCESS;
    DATA_OUT <= RAM(to_integer(unsigned(ADDR)));
END arch;