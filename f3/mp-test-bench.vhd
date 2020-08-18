LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mp_testbench IS
END mp_testbench;

ARCHITECTURE BEHAVIORAL OF mp_testbench IS

  COMPONENT mp IS PORT (
    clock, reset : IN STD_LOGIC;
    input : IN unsigned(7 DOWNTO 0);
    enter : IN STD_LOGIC;
    output : OUT unsigned(7 DOWNTO 0);
    halt : OUT STD_LOGIC
    );
  END COMPONENT;
  SIGNAL clk : STD_LOGIC;
  SIGNAL op : UNSIGNED(7 DOWNTO 0);
  FOR microprocessor : mp USE ENTITY work.mp;

  SIGNAL reset : STD_LOGIC;
  SIGNAL input : unsigned(7 DOWNTO 0);
  SIGNAL enter : STD_LOGIC;
  SIGNAL output : unsigned(7 DOWNTO 0);
  SIGNAL halt : STD_LOGIC;

BEGIN
  microprocessor : mp PORT MAP(
    clock => clk,
    reset => reset,
    enter => enter,
    input => input
  );

  clk_process : PROCESS
    CONSTANT clk_period : TIME := 1 ns;
  BEGIN
    clk <= '0';
    WAIT FOR clk_period/2;
    clk <= '1';
    WAIT FOR clk_period/2;
  END PROCESS;

  input_process : PROCESS
    CONSTANT clk_period : TIME := 1 ns;
  BEGIN
    RESET <= '1';
    INPUT <= "00000001";
    ENTER <= '1';
    WAIT FOR clk_period/10;
    RESET <= '0';
    WAIT;
  END PROCESS;
END BEHAVIORAL;