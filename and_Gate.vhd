library ieee;
use ieee.std_logic_1164.all;

-- Defining entities. Like a table of contents
entity example_and is
  port (
    input_1 : in std_logic;
    input_2 : in std_logic;
    and_result : out std_logic

  );
end example_and;

-- Defining Architecture
architecture rtl of example_and is
  signal and_gate : std_logic; -- Create a signal with name and gate

begin
  and_gate <= input_1 and input_2; -- Assigning inputs
  and_result <= and_gate; -- Assignnig outputs

end rtl;