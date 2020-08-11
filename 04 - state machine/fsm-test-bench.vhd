LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fsm_testbench IS
END fsm_testbench;

ARCHITECTURE BEHAVIORAL OF fsm_testbench IS

  COMPONENT FSM IS PORT (
    A : IN STD_LOGIC;
    O : OUT UNSIGNED(2 DOWNTO 0);
    CLK : IN STD_LOGIC
    );
  END COMPONENT;

  SIGNAL CLK : STD_LOGIC;
  SIGNAL A : STD_LOGIC;
  SIGNAL O : UNSIGNED(2 DOWNTO 0);
  FOR FSM_DEVICE : FSM USE ENTITY work.FSM;

BEGIN
  FSM_DEVICE : FSM PORT MAP(
    CLK => CLK,
    A => A,
    O => O
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
    A <= '0';
    WAIT FOR clk_period * 5;
    A <= '1';
    WAIT;
  END PROCESS;
END BEHAVIORAL;