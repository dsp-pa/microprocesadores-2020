
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mp IS PORT (
    clock, reset : IN STD_LOGIC;
    input : IN unsigned(7 DOWNTO 0);
    enter : IN STD_LOGIC;
    output : OUT unsigned(7 DOWNTO 0);
    halt : OUT STD_LOGIC
);
END mp;

ARCHITECTURE FSMD OF mp IS
    TYPE state_type IS(
    s_start,
    s_halt);
    SIGNAL state : state_type;
    SIGNAL IR : unsigned(7 DOWNTO 0);
    SIGNAL PC : unsigned(4 DOWNTO 0);
    SIGNAL A : unsigned(7 DOWNTO 0);
    SIGNAL memory_address : unsigned(4 DOWNTO 0);
    SIGNAL memory_data : unsigned(7 DOWNTO 0);
    SIGNAL write_enable : STD_LOGIC;
    COMPONENT RAM_8BITS IS
        GENERIC (
            addr_width : INTEGER := 5;
            data_width : INTEGER := 8
        );

        PORT (
            clk : IN std_logic;
            we : IN std_logic;
            addr : IN UNSIGNED(addr_width - 1 DOWNTO 0);
            din : IN UNSIGNED(data_width - 1 DOWNTO 0);
            dout : OUT UNSIGNED(data_width - 1 DOWNTO 0)
        );
    END COMPONENT;
BEGIN

    MEMORY : RAM_8BITS GENERIC MAP(
        addr_width => 5,
        data_width => 8
    )
    PORT MAP(
        clk => clock,
        we => write_enable,
        addr => memory_address,
        din => memory_data,
        dout => memory_data
    );

    PROCESS (clock, reset)
    BEGIN
        IF (reset = '1') THEN
            PC <= "00000";
            IR <= "00000000";
            A <= "00000000";
            write_enable <= '0';
            halt <= '0';
            state <= s_start;
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE state IS
                WHEN s_start =>
                    memory_address <= PC;
                    state <= s_halt;
                WHEN s_halt => halt <= '1';
                    state <= s_halt;
                WHEN OTHERS => state <= s_halt;
            END CASE;
        END IF;

    END PROCESS;
    output <= A;

END FSMD;