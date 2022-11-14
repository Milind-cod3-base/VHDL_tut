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

  -- Above signals will toggle at the frequencies needed:
  signal r_TOGGLE_100Hz : std_logic := '0';
  signal r_TOGGLE_50Hz : std_logic := '0';
  signal r_TOGGLE_10Hz : std_logic := '0';
  signal r_TOGGLE_1Hz : std_logic := '0';
  
  -- One bit select wire.
  signal w_LED_SELECT : std_logic;


begin
    -- All processes toggle a specific signal at a different frequency. 
    -- They all run continuously even if the switches are
    -- not selecting their particular output.

    p_100_Hz : process (i_clock) is
    begin
        if rising_edge(i_clock) then
            if r_CNT_100Hz= c_CNT_100Hz -1 then -- -1, since counter starts from 0
                r_TOGGLE_100Hz <= not r_TOGGLE_100Hz;
                r_CNT_100Hz <= 0;
            
            else
                r_CNT_100Hz <= r_CNT_100Hz + 1;
            end if;
        end if;
    end process p_100_Hz;

    p_50_Hz : process (i_clock) is
    begin
        if rising_edge(i_clock) then
            if r_CNT_50Hz= c_CNT_50Hz -1 then -- -1, since counter starts from 0
                r_TOGGLE_50Hz <= not r_TOGGLE_50Hz;
                r_CNT_50Hz <= 0;
            
            else
                r_CNT_50Hz <= r_CNT_50Hz + 1;
            end if;
        end if;
    end process p_50_Hz;

    p_10_Hz : process (i_clock) is
    begin
        if rising_edge(i_clock) then
            if r_CNT_10Hz= c_CNT_10Hz -1 then -- -1, since counter starts from 0
                r_TOGGLE_10Hz <= not r_TOGGLE_10Hz;
                r_CNT_10Hz <= 0;
            
            else
                r_CNT_10Hz <= r_CNT_10Hz + 1;
            end if;
        end if;
    end process p_10_Hz;

    p_1_Hz : process (i_clock) is
    begin
        if rising_edge(i_clock) then
            if r_CNT_1Hz= c_CNT_1Hz -1 then -- -1, since counter starts from 0
                r_TOGGLE_1Hz <= not r_TOGGLE_1Hz;
                r_CNT_1Hz <= 0;
            
            else
                r_CNT_1Hz <= r_CNT_1Hz + 1;
            end if;
        end if;
    end process p_1_Hz;

    -- Create a multiplexer based on switch inputs
    w_LED_SELECT <= r_TOGGLE_100Hz when (i_switch_1 = '0' and i_switch_2 = '0') else
                    r_TOGGLE_50Hz when (i_switch_1 = '0' and i_switch_2 = '1') else
                    r_TOGGLE_10Hz when (i_switch_1 = '1' and i_switch_2 = '0') else
                    r_TOGGLE_1Hz;

        
                    