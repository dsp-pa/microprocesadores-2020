LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE BEHAVIORAL OF testbench IS

  COMPONENT D_flipflop
    PORT (
      D, Clock : IN STD_LOGIC;
      Q : OUT STD_LOGIC);
  END COMPONENT;

  FOR FF : D_flipflop USE ENTITY work.D_flipflop;
  SIGNAL D, Clock, Q : std_logic;
  SIGNAL loop_var : INTEGER := 0;

BEGIN
  FF : D_flipflop PORT MAP(D => D, Clock => Clock, Q => Q);
  INPUT : PROCESS
    TYPE pattern_type IS RECORD
      D, Clock, Q : std_logic;
    END RECORD;
    TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
    CONSTANT patterns : pattern_array :=
    (('0', '1', '0'),
    ('1', '1', '0'));
  BEGIN
    FOR i IN patterns'RANGE LOOP
      D <= patterns(i).D;
      WAIT FOR 2 ns;
    END LOOP;
  END PROCESS;

  clk : PROCESS
    CONSTANT clk_period : TIME := 1 ns;
    CONSTANT cycles : INTEGER := 20;
  BEGIN
    Clock <= '0';
    WAIT FOR clk_period/2;
    Clock <= '1';
    WAIT FOR clk_period/2;

    IF (loop_var < cycles) THEN
      loop_var <= loop_var + 1;
    ELSE
      WAIT;
    END IF;

  END PROCESS;
END BEHAVIORAL;