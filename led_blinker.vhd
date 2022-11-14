library ieee;
use ieee.std_logic_1164.all.all;
use ieee.numeric_std.all;
--defining contents of code in entity
entity led_blink is port (
  i_clock : in std_logic;
  i_enable : in std_logic;
  i_switch_1 : in std_logic;
  i_switch_2 : in std_logic;
  o_led_drive : in std_logic
);

end led_blink;

-- defining architecture
architecture rtl of led_blink is

  -- Constants to create the frequencies needed
  -- formula is: (25 MHz / 100 Hz * 50% duty cycle)
  -- So for 100 Hz: 25,000,000 / 100 * 0.5 = 125,000
  constant c_CNT_100Hz : natural := 125000;
  constant c_CNT_50Hz : natural := 250000;
  constant c_CNT_10Hz : natural := 1250000;
  constant c_CNT_1Hz : natural := 12500000;

  -- These signals will be the counters:
  -- For the design there are four counter processes that run concurrently. 
  -- This means that they are all running at the exact same time. 
  -- Their job is to keep track of the number of clock pulses seen for each of the different frequencies. 
  -- Even if the switches are not selecting that particular frequency, the counters are still running!
  signal r_CNT_100Hz : natural range 0 to c_CNT_100Hz;
  signal r_CNT_50Hz : natural range 0 to c_CNT_50Hz;
  signal r_CNT_10Hz : natural range 0 to c_CNT_10Hz;
  signal r_CNT_1Hz : natural range 0 to c_CNT_1Hz;