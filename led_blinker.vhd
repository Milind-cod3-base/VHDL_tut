library ieee;
use ieee.std_logic_1164.all.all;
use ieee.numeric_std.all;


--defining contents of code in entity
entity led_blink is port(
    i_clock : in std_logic;
    i_enable : in std_logic;
    i_switch_1 : in std_logic;
    i_switch_2 : in std_logic;
    o_led_drive : in std_logic
    );

end led_blink;


    

    