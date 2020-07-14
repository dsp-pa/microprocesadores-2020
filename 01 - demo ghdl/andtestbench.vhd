library IEEE;
use IEEE.std_logic_1164.all;

entity andtestbench is
end andtestbench;

architecture BEHAVIORAL of andtestbench is
  --  Declaration of the component that will be instantiated.
  component ANDGATE
    port (I1, I2 : in std_logic; O : out std_logic);
  end component;

  --  Specifies which entity is bound with the component.
  for ANDGATE0: ANDGATE use entity work.ANDGATE;
  signal I1, I2, O : std_logic;
begin
  --  Component instantiation.
  ANDGATE0: ANDGATE port map (I1 => I1, I2 => I2, O => O);

  --  This process does the real job.
  process
    type pattern_type is record
      I1, I2 : std_logic;
      O : std_logic;
    end record;
    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
      (('0', '0', '0'),
       ('0', '1', '0'),
       ('1', '1', '1'));
  begin
    for i in patterns'range loop
      I1 <= patterns(i).I1;
      I2 <= patterns(i).I2;

      wait for 1 ns;
      assert O = patterns(i).O
        report "BAD AND value" severity error;
    end loop;
    assert false report "end of test" severity note;
    wait;
  end process;

end BEHAVIORAL;